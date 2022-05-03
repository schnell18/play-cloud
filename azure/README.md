# Introduction

Simple deployment automation for Azure cloud deployment using Terraform.

## Pre-requisite

You need install softwares as follows:

- [Azure CLI][1]

## Process to bootstrap infrustrate on Azure

First You should login Azure:

    az login

Next, you change to top level directory:

    cd terraform
    tf init
    tf validate
    tf plan
    tf apply

## Other useful tools

Tools mentioned in the following sections are nice-to-have. Some of these tools
are at very early stage and may not work out-of-box.

### Find CentOS OS image

Use this command to find publisher/offer/SKU/version of CentOS:

    az vm image list --offer CentOS --all --output table


[1]: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli
[3]: https://28mm.github.io/blast-radius-docs/
[5]: https://www.ansible.com/

