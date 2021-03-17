#!/bin/bash

KEY=$1
SUBNET=$(aws ec2 describe-subnets --query "Subnets[0].SubnetId" --output text)
IMAGE="ami-042e8287309f5df03"
VPCID=$(aws ec2 describe-subnets --query "Subnets[0].VpcId" --output text)
SGID=$(aws ec2 create-security-group --group-name Atividade15 --description "Atividade15 description" --vpc-id $VPCID --output text)

aws ec2 authorize-security-group-ingress --group-name Atividade15 --protocol tcp --port 80 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-name Atividade15 --protocol tcp --port 22 --cidr 0.0.0.0/0

echo "Criando servidor de Monitoramento..."

IDINSTANCE=$(aws ec2 run-instances --image-id $IMAGE --instance-type "t2.micro" --key-name $KEY --security-group-ids $SGID --subnet-id $SUBNET --user-data file://auxiliar.sh --query "Instances[0].InstanceId" --output text)

#Para nao tentar pegar rapido demais e da tempo para criar
while true; do
    status=$(aws ec2 describe-instances --instance-id $InstanceId --query "Reservations[0].Instances[0].State.Name" --output text)
    if [[ $status == 'running' ]]; then
        echo "Estado \"running\""
        break
    fi
done

IP=$(aws ec2 describe-instances --instance-id $IDINSTANCE --query "Reservations[0].Instances[0].PublicIpAddress" --output text)

echo "Acesse: http://${IP}/"