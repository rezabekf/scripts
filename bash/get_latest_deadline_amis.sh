#!/usr/bin/env bash

# get all the AWS regions
regions=$(aws ec2 describe-regions --query Regions[].RegionName | jq '.[]' -r)

# go through all the AWS regions and grab CentOS 7 AMI ID
while read -r line; do
    printf "${line}\n$(aws ec2 describe-images \
        --owners '357466774442' \
        --filters 'Name=name,Values=Deadline Slave Base Image 10.* with Maya * and Arnold' \
        --query 'Images[*].[ImageId,CreationDate]' \
        --region ${line} \
        --output text | \
        sort -k2 -r | head -n1 | cut -f 1)\n"
done <<< ${regions}