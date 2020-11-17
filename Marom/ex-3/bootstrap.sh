#!/bin/bash
#This bootstrap script installs Git, configures it, and installs Docker and runs a Jenkins container.

# Git installation
wget https://github.com/git/git/archive/v2.29.1.tar.gz -O git.tar.gz
tar -zxf git.tar.gz
# The next line cds to the last created folder, whuch is the extracted files' folder
cd  "$(\ls -1dt ./*/ | head -n 1)"
./configure --prefix=/usr/local
make install

#Git initial setup:
# The argument $1 will be the username and the second argument will be the email address...
git config --global user.name $1
git config --global user.email $2

if [ -z "$1" ]
then echo "\$1 is empty. Please rerun this script with proper parameter input."
else
if [ -z "$2" ]
then echo "\$2 is empty. Please rerun this script with proper parameter input."
else
echo "This is your Git user name:"
git config user.name
echo "This is your Git user email:"
git config user.email

#SSH keys setup with an empty passphrase and overwrite any existing key file
ssh -V
ls -lah ~/.ssh
ssh-keygen -t rsa -b 4096 -P "" -f
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub
ssh -T git@github.com

# Docker installation
yum install -y yum-utils
yum check-update
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install docker --skip-broken
yum install docker-ce docker-ce-cli containerd.io
systemctl start docker
systemctl enable docker

# Jenkins container setup
docker volume create jenkins-data
docker pull jenkins/jenkins:lts
docker run -d -p 8080:8080 -v jenkins-data:/var/jenkins_master --name jenkins-master jenkins/jenkins:lts
docker start jenkins-master
echo "This is the initial admin password for Jenkins:"
docker exec -it jenkins-master sh -c "cat /var/jenkins_home/secrets/initialAdminPassword"
# This line allows Jenkins' port 8080 through the firewall.
# Since I'm using an EC2 instance, there is no internal firewall here, so the command is commented. 
# ufw allow 8080

#This part checks Jenkins connectivity post-installation:
ss -nutlp | grep 8080
if [ $? -eq 0 ]
then
  echo "Jenkins is listening on port 8080"
else
  echo "Port 8080 is currently closed. Check your Jenkins installation" >&2
fi

