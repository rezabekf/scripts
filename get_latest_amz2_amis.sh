#!/usr/bin/env bash

# get the all AWS regions
regions=$(aws ec2 describe-regions --query Regions[].RegionName | jq '.[]' -r)

# go through all regions and grab AMI
while read -r line; do
    printf "$line\n$(aws ssm get-parameters --names \
        /aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2 \
        --query Parameters[].Value --region ${line} | jq '.[]' -r)\n"
done <<< ${regions}
