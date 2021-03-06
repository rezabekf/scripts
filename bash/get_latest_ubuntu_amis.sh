#!/usr/bin/env bash

# get all the AWS regions
regions=$(aws ec2 describe-regions --query Regions[].RegionName | jq '.[]' -r)

# go through all the AWS regions and grab Ubuntu 18.04 LTS AMI ID
while read -r line; do
    printf "${line}\n$(aws ec2 describe-images \
        --filters Name=name,Values=ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64* \
        --query 'Images[*].[ImageId,CreationDate]' \
        --region ${line} \
        --output text | \
        sort -k2 -r | head -n1 | cut -f 1)\n"
done <<< ${regions}
