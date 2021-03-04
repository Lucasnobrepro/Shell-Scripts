#!/bin/bash
SUBNET=$(aws ec2 describe-subnets --query "Subnets[0].SubnetId" --output text)
IMAGE="ami-03d315ad33b9d49c4"
KEY=$1
VPCID=$(aws ec2 describe-subnets --query "Subnets[0].VpcId" --output text)
SGI=$(aws ec2 create-security-group --group-name SG2 --description "Segurity Group 2" --vpc-id $VPCID --output text)
#SGI=$(aws ec2 describe-security-groups --query "SecurityGroups[0].GroupId" --output text)

aws ec2 authorize-security-group-ingress --group-name SG2 --protocol tcp --port 22 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-name SG2 --protocol tcp --port 80 --cidr 0.0.0.0/0

echo "Criando servidor..."
INTID=$("aws ec2 run-instances --image-id $IMAGE --instance-type "t2.micro" --key-name $KEY --security-group-ids $SGI --subnet-id $SUBNET -user-data file://script.sh --output text")

IPPUBLIC=$(aws ec2 describe-instances --query "Reservations[0].Instances[0].PublicIpAddress" --output text)

echo "Acesse: http://$IPPUBLIC/"