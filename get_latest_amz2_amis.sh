#!/usr/bin/env bash

# get all the AWS regions
regions=$(aws ec2 describe-regions --query Regions[].RegionName | jq '.[]' -r)

# go through all the AWS regions and grab Amazon Linux 2 AMIs for them
while read -r line; do
    printf "$line\n$(aws ssm get-parameters --names \
        /aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2 \
        --query Parameters[].Value --region ${line} | jq '.[]' -r)\n"
done <<< ${regions}
