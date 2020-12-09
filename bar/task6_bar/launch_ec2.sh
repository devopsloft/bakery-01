#!/usr/bin/env bash
echo "Create the new instance on the aws."
aws ec2 create-key-pair --key-name bar --query 'KeyMaterial' --output text > bar.pem
chmod 755 bar.pem
sg=`aws ec2 create-security-group --group-name barSg --description "this is an test security group" --output text`
echo $sg
aws ec2 run-instances --image-id ami-032e5b6af8a711f30 --security-group-ids $sg --instance-type t2.micro --key-name bar
aws ec2 authorize-security-group-ingress --group-name $sg --protocol tcp --port 22 --cidr 0.0.0.0/0
instanceID=`aws ec2 describe-instances --query 'Reservations[0].Instances[0].InstanceId' --output text`
echo $instanceID
publicIP=`aws ec2 describe-instances --instance-ids $instanceID --query 'Reservations[0].Instances[0].PublicIpAddress' --output text`
echo $publicIP
ssh -i bar.pem ec2-user@$publicIP
