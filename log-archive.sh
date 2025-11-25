#!/bin/bash

log_path=$1
echo "Path for log directory: $log_path"

if [ $EUID -ne 0 ]; then
    echo "Error: Please run this script with 'sudo -E'"
    exit 1
fi
echo

echo "Checking if the S3 bucket variable exists..."
if [ -z "${S3_BUCKET}" ]; then
    echo "Error: Please set the ENV environment 'S3_BUCKET'"
    exit 1
else
    echo "S3 bucket selected: $s3_bucket"
fi
echo

echo "Validating AWS Session..."
if aws sts get-caller-identity > /dev/null 2>&1; then
    echo "AWS Session is valid:"
    aws sts get-caller-identity
else
    echo "Error: Please run 'aws login' in the terminal to proceed"
    exit 1
fi

echo

if [ -d "$log_path" ]; then
    cd $log_path
    echo "File count: $(ls -1 | wc -l)"
    echo "Size: $(du -h | awk '{ print $1 }')"
    echo

    date_time=$(date -u +%Y%m%d_%I%M%S)
    file_name="logs_archive_$date_time.tar.gz"

    tar cvzf $file_name ./* > /dev/null 2>&1

    if [ $? == 0 ]; then
        echo "Logs compressed in the file: $file_name"
        echo

        echo "Copying the tar file to the S3 Bucket..."
        aws s3 cp $file_name $s3_bucket > /dev/null 2>&1

        if [ $? = 0 ]; then
            echo "Successfully copied the file $file_name to the S3 bucket $s3_bucket"
            echo
            echo "Cleaning the directory..."
            rm -r ./*
        else
            echo "Error: Unable to copy the file $file_name to the S3 bucket $s3_bucket"
        fi
        echo
    else
        echo "Error: Unable to compress the files"
        exit 1
    fi
else
    echo "Error: Directory $file_path doesn't exist"
fi