#!/bin/bash
# Correção: 1,0

CHAVE=$1
USUARIO=$2
SENHA=$3
VPCID=$(aws ec2 describe-subnets --query "Subnets[0].VpcId" --output text)
GroupName="ativid19"
IPLOCAL=$(curl ifconfig.me)
SUBREDE=$(aws ec2 describe-subnets --query "Subnets[0].SubnetId" --output text)
IMAGE="ami-042e8287309f5df03"

SGID=$(aws ec2 create-security-group --group-name $GroupName --description "$GroupName description" --vpc-id $VPCID --output text)
    
aws ec2 authorize-security-group-ingress --group-name $GroupName --protocol tcp --port 22 --cidr $IPLOCAL/32
aws ec2 authorize-security-group-ingress --group-name $GroupName --protocol tcp --port 80 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-name $GroupName --protocol tcp --port 3306 --source-group $SGID

SubnetGroupNameRDS=$(aws rds describe-db-subnet-groups --query "DBSubnetGroups[0].DBSubnetGroupName" --output text)
    
echo "Criando instância de Banco de Dados no RDS..."

DBName="dblucas"

aws rds create-db-instance --db-instance-identifier $DBName --db-instance-class db.t2.micro --engine mysql --master-username admin --master-user-password admin1234 --vpc-security-group-ids $SGID --no-publicly-accessible --allocated-storage 20 --db-subnet-group-name $SubnetGroupNameRDS > /dev/null

while true; do
    DBStatus=$(aws rds describe-db-instances --db-instance-identifier $DBName --query "DBInstances[0].DBInstanceStatus" --output text)
    if [[ $DBStatus == 'available' ]]; then
        break
    fi
done

Endpoint=$(aws rds describe-db-instances --db-instance-identifier $DBName --query "DBInstances[0].Endpoint.Address" --output text)

echo "Endpoint do RDS: $Endpoint"

# Correção: Não era para substituir o HOST também?
sed -Ei "s/USUARIO/$USUARIO/" ./servidorWeb.sh
sed -Ei "s/PRIVADOIP/$Endpoint/" ./servidorWeb.sh 
sed -Ei "s/SENHA/$SENHA/" ./servidorWeb.sh 

echo "Criando servidor de Aplicação..."

InstanceId=$(aws ec2 run-instances --image-id $IMAGE --instance-type "t2.micro" --key-name $CHAVE --security-group-ids $SGID --subnet-id $SUBREDE --user-data file://servidorWeb.sh --query "Instances[0].InstanceId" --output text)

# Correção: Existe InstanceId2? O laço a seguir nunca irá retornar.
while true; do
    status=$(aws ec2 describe-instances --instance-id $InstanceId2 --query "Reservations[0].Instances[0].State.Name" --output text)
    if [[ $status == 'running' ]]; then
        break
    fi
done

PublicIP=$(aws ec2 describe-instances --instance-id $InstanceId2 --query "Reservations[].Instances[].PublicIpAddress" --output text)

echo "IP Público do Servidor de Aplicação: ${PublicIP}"

echo "Acesse http://${PublicIP}/wordpress para finalizar a configuração."
