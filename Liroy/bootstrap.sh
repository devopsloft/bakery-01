#!/usr/bin/env bash

if [ "$(id -un)" != "root" ]; then
  echo "sudoing.."
  exec sudo "$0" "$@" || echo "You do not have root permission!" && exit 1
fi

echo "Updating system"
yum -y update
yum -y install epel-release yum-utils
yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

echo "Installing git"
yum -y install git

echo "Checking for existing SSH keys..."
FILE=~/.ssh/id_rsa.pub
if [[ -f "$FILE" ]]; then
  echo "There is already existing ssh key."
else
  echo "Generating a new key..."
  read -p "Please enter your GitHub email" user_email
  ssh-keygen -t rsa -b 4096 -C $user_email
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_rsa
fi

echo "Installing Docker"
yum -y install docker-ce docker-ce-cli containerd.io
yum list installed | grep docker
if [[ $? -eq 0 ]]; then
  echo "Docker installation succeeded"
else
  echo "Docker installation failed"
fi

echo "Installing java..."
yum -y install java
echo "Adding environment variables"
cp /etc/profile /etc/profile.$$ #backup /etc/profile 
echo 'export JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk' | sudo tee -a /etc/profile
echo 'export JRE_HOME=/usr/lib/jvm/jre' | sudo tee -a /etc/profile
source /etc/profile
echo "Installing jenkins"
cd ~
echo "Installing wget..."
yum -y install wget
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum -y install jenkins && echo "Jenkins Installation succeeded"

echo "Starting Jenkins container"
sudo service docker start
sudo docker run -d -v jenkins_home:/var/jenkins_home -p 11000:8080 jenkins/jenkins


echo "Goodbye"

