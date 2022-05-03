# Introduction

Simple cloud deployment automation for major public cloud using Terraform.

## Catalog

| --- sub-folder --- | ------------- description ---------- |
| aws                | aws auto-provision                   |
| azure              | Microsoft azure cloud auto-provision |
| ------------------ | ------------------------------------ |

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

