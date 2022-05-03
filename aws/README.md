# Introduction

Simple cloud deployment automation for AWS using Terraform.

## Pre-requisite

You need install softwares as follows:

- [AWS CLI][1]

You download the software and install manually. Or you can install with a
pacakge manager.  On MacOS X, you may install Terraform by using brew as:

    brew tap hashicorp/tap
    brew install hashicorp/tap/terraform

## Process to bootstrap infrustrate on AWS

First You should config AWS cli as follows:

    cat<<EOF > ~/.aws/config
    [default]
    region = ap-northeast-1
    output = json
    EOF

    cat<<EOF > ~/.aws/credentials
    [default]
    aws_access_key_id = ********************
    aws_secret_access_key = ****************************************
    EOF

Next, you change to top level directory:

    cd terraform
    tf init
    tf validate
    tf plan
    tf apply

[1]: https://aws.amazon.com/cli/?nc1=h_ls

