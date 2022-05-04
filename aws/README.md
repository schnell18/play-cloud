# Introduction

Simple cloud deployment automation for AWS using Terraform.

This project provisions a free-tier EC2 host and a free-tier RDS MySQL db.
The EC2 host runs debian 10 w/ 1C1G and 30G disk space.
The RDS MySQL run MySQL 8.0.28 w/ 2C1G and 20G storage space.

The EC2 host is accessible from internet. The RDS MySQL can only be reached
within the VPC. The network topology diagram is as follows:

       +-------------------------------------------------------------------+
       |                              Internet                             |
       |                                                                   |
       +---------------------------------|---------------------------------+
                                         |
       +---------------------------------|---------------------------------+
       |                           +--------------+                        |
       |                +----------|     IGW      |       VPC 10.30.0.0/16 |
       |                |          +--------------+                        |
       |                |                                                  |
       |                |                                                  |
       |   +-------------------------+      +------------------------+     |
       |   |  Internet facing subnet |      |   subnet 10.30.49.0/24 |     |
       |   |       10.30.2.0/24      |      |                        |     |
       |   |                         |      |  +------------------------+  |
       |   |      EC2 debian 10      |      |  |  subnet 10.30.50.0/24  |  |
       |   |                         |------|  |                        |  |
       |   |                         |      |  |                        |  |
       |   |                         |      |  |                        |  |
       |   |                         |      |  |        MySQL 8.0.28    |  |
       |   |                         |      |  |                        |  |
       |   +-------------------------+      +--|                        |  |
       |                                       |                        |  |
       |                                       |                        |  |
       |                                       +------------------------+  |
       |                                                                   |
       |                                                                   |
       +-------------------------------------------------------------------+

To provision infrastructure illustrated above w/ terraform, you need create AWS
resources (including supporting resources such key pair, subnet etc) as
folllows:

- VPC
- EC2 instance
- RDS

Creating VPC resources requires following resources to be created:

- subnet
- security group
- internet gateway
- route table
- route table association

To maintain good security while enabling internet access, you need please
hosts accessible to internet in a dedicated subnet. The RDS usually requires
you create more than one subnet on different available zones.
As a result this project create four subnet with follow CIDR allocations:

- 10.30.1.0/24 for backend application with no need to access internet
- 10.30.2.0/24 for hosts accessible from/to internet
- 10.30.49.0/24 for RDS on az one
- 10.30.50.0/24 for RDS on az two

The code to provision this VPC is located in file `vnet/main.tf`.

## Pre-requisite

You need install softwares as follows:

- [AWS CLI][1]

You download the software and install manually. Or you can install with a
pacakge manager. For detailed instruction on install and setup AWS CLI,
please refer to [official document][2].

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
[2]: https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html

