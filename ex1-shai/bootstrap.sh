#!/usr/bin/env bash

#Install docker
yum update -y 
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
echo "Installing docker....."
yum install -y docker-ce docker-ce-cli containerd.io
systemctl enable docker
systemctl start docker

systemctl is-active --quiet docker && echo Docker is running

echo "Installing java"
yum install -y java-1.8.0-openjdk

export JAVA_HOME=/usr/bin/java

which wget > /dev/null 2>&1
if [[ $? -eq 1 ]]; then
        sudo yum install -y wget
else
        echo "wget installed"
fi

wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key

echo "Installing jenkins"
yum install -y jenkins
systemctl enable jenkins
systemctl start jenkins

systemctl is-active --quiet jenkins && echo Jenkins is running
