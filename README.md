# Log Archive Tool Project

![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black) ![Bash](https://img.shields.io/badge/Bash-4EAA25?style=for-the-badge&logo=gnubash&logoColor=white) ![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)

## About the Project

This project was proposed in the [DevOps Path from roadmap.sh](https://roadmap.sh/projects/log-archive-tool), with the objective of creating a tool to **compress logs** in a given directory, **copy the `tar.gz` file to a bucket S3** and clean the directory, for **archiving purposes**.

## Prerequisites

Verify if `AWS-CLI` is installed on your Linux terminal by running:

```bash
aws --version
```

Note: If AWS-CLI is not installed, refer to the [Installing or updating to the latest version of the AWS CLI (AWS)](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) documentation

## Usage

To use the tool, first you need to **authenticate with AWS** using the command:

```bash
aws login
```

Next, export the S3 bucket URL (`s3://` + Bucket name) as an **environment variable** named `S3_BUCKET`, as shown below:
```bash
export S3_BUCKET="s3://bucket_name"
```

Then you can run the command below to execute the script using `sudo -E` for the required permissions and to preserve the AWS session from the previous step:

```bash
sudo -E ./log-archive.sh /path/file

```
