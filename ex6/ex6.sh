#!/usr/bin/env bash

echo "Create the new instance on the aws."
aws ec2 create-key-pair --key-name test-key --query 'KeyMaterial' --output text > test-key.pem
chmod 755 test-key.pem
securityGroup=`aws ec2 create-security-group --group-name testSecurityGroup --description "this is an test security group" --output text`
echo $securityGroup
aws ec2 run-instances --image-id ami-032e5b6af8a711f30 --security-group-ids $securityGroup --instance-type t2.micro --key-name test-key
aws ec2 authorize-security-group-ingress --group-name $securityGroup --protocol tcp --port 22 --cidr 0.0.0.0/0 
#aws ec2 describe-instances | grep InstanceId
instanceID=`aws ec2 describe-instances --query 'Reservations[0].Instances[0].InstanceId' --output text`
echo $instanceID
publicIP=`aws ec2 describe-instances --instance-ids $instanceID --query 'Reservations[0].Instances[0].PublicIpAddress' --output text`
echo $publicIP
ssh -i test-key.pem ec2-user@$publicIP
