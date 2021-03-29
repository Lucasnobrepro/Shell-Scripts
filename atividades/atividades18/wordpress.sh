#!/bin/bash

CHAVE=$1
USUARIO=$2
SENHA=$3
IPLOCAL=$(curl ifconfig.me)
IMAGE="ami-042e8287309f5df03"
GROUPNAME="atv18"
SUBREDE=$(aws ec2 describe-subnets --query "Subnets[0].SubnetId" --output text)
VPCID=$(aws ec2 describe-subnets --query "Subnets[0].VpcId" --output text)

SGID=$(aws ec2 create-security-group --group-name $GROUPNAME --description "$GROUPNAME description" --vpc-id $VPCID --output text)
aws ec2 authorize-security-group-ingress --group-name $GROUPNAME --protocol tcp --port 22 --cidr $IPLOCAL/32
aws ec2 authorize-security-group-ingress --group-name $GROUPNAME --protocol tcp --port 80 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-name $GROUPNAME --protocol tcp --port 3306 --source-group $SGID

sed -Ei "s/USUARIO/$USUARIO/" ./database.sh 
sed -Ei "s/SENHA/$SENHA/" ./database.sh

echo "Criando servidor de Banco de Dados..."

InstanceId1=$(aws ec2 run-instances --image-id $IMAGE --instance-type "t2.micro" --key-name $CHAVE --security-group-ids $SGID --subnet-id $SUBREDE --user-data file://database.sh --query "Instances[0].InstanceId" --output text)

while true; do
    status=$(aws ec2 describe-instances --instance-id $InstanceId1 --query "Reservations[0].Instances[0].State.Name" --output text)
    if [[ $status == 'running' ]]; then
        break
    fi
done

PrivateIP=$(aws ec2 describe-instances --instance-id $InstanceId1 --query "Reservations[].Instances[].PrivateIpAddress" --output text)
echo "IP Privado do Banco de Dados: $PrivateIP"

sleep 30

sed -Ei "s/USUARIO/$USUARIO/" ./servidorWeb.sh
sed -Ei "s/PRIVADOIP/$PrivateIP/" ./servidorWeb.sh 
sed -Ei "s/SENHA/$SENHA/" ./servidorWeb.sh 

echo "Criando servidor de Aplicação..."

InstanceId2=$(aws ec2 run-instances --image-id $IMAGE --instance-type "t2.micro" --key-name $CHAVE --security-group-ids $SGID --subnet-id $SUBREDE --user-data file://servidorWeb.sh --query "Instances[0].InstanceId" --output text)

while true; do
    status=$(aws ec2 describe-instances --instance-id $InstanceId2 --query "Reservations[0].Instances[0].State.Name" --output text)
    if [[ $status == 'running' ]]; then
        break
    fi
done

PublicIP=$(aws ec2 describe-instances --instance-id $InstanceId2 --query "Reservations[].Instances[].PublicIpAddress" --output text)

echo "IP Público do Servidor de Aplicação: ${PublicIP}"

echo "Acesse http://${PublicIP}/wordpress para finalizar a configuração."