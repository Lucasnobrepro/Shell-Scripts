#!/bin/bash
SUBNET=$(aws ec2 describe-subnets --query "Subnets[0].SubnetId" --output text)
IMAGE="ami-03d315ad33b9d49c4"
KEY=$1
VPCID=$(aws ec2 describe-instances --query "Reservations[1].Instances[0].VpcId" --output text)
SGI=$(aws ec2 create-security-group --group-name MySecurityGroup --description "My security group" --vpc-id $VPCID --output text)
#SGI=$(aws ec2 describe-security-groups --query "SecurityGroups[0].GroupId" --output text)

echo "Criando instacia!"
aws ec2 run-instances --image-id $IMAGE --instance-type "t2.micro" --key-name $KEY --security-group-ids $SGI --subnet-id $SUBNET

IPPUBLIC=$(aws ec2 describe-instances --query "Reservations[1].Instances[0].PublicIpAddress" --output text)

echo "IP PUBLICO: $IPPUBLIC"