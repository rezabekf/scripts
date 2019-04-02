#!/usr/bin/env bash

# get all the AWS regions
regions=$(aws ec2 describe-regions --query Regions[].RegionName | jq '.[]' -r)

# go through all the AWS regions and grab Amazon Linux 2 AMIs for them
while read -r line; do
    printf "${line}\n$(aws ec2 describe-images \
        --filters Name=name,Values=ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64* \
        --query 'Images[*].[ImageId,CreationDate]' \
        --region ${line} \
        --output text | \
        sort -k2 -r | head -n1 | cut -f 1)\n"
done <<< ${regions}
