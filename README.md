# Introduction

Simple cloud deployment automation for major public cloud using Terraform.

## Catalog

|     sub-folder     |               description            |
| ------------------ | ------------------------------------ |
| aws                | aws auto-provision                   |
| azure              | Microsoft azure cloud auto-provision |

## AWS

This project provisions a free-tier EC2 host and a free-tier RDS MySQL db. The
EC2 host runs debian 10 w/ 1C1G and 30G disk space. The RDS MySQL run MySQL
8.0.28 w/ 2C1G and 20G storage space.

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

The project demonstrates how easy it takes to provision infrastructure w/
terraform in just a few mintues.

## Pre-requisite

You need install softwares as follows:

- [Terraform][1]
- [Ansible][2]

You download the software and install manually. Or you can install with a
pacakge manager.  On MacOS X, you may install Terraform by using brew as:

    brew tap hashicorp/tap
    brew install hashicorp/tap/terraform

Then you setup alias for `terraform` to save typing:

    alias tf=terraform

### visualize terraform

You can use [Blastradius][3] to visualize your terraform project.

To use this tool, you install blastradius python module and graphviz.
On MacOS X, you type the following command to install them:

    pip3 install blastradius
    brew install graphviz

Then you launch a local web server to visualize your terraform project:

    blast-radius --serve .

### use ansible with terraform

You can use remote-exec or [this plugin][4] to call ansible in terraform.

[1]: https://www.terraform.io/downloads.html
[2]: https://www.ansible.com/
[3]: https://28mm.github.io/blast-radius-docs/
[4]: https://github.com/radekg/terraform-provisioner-ansible

