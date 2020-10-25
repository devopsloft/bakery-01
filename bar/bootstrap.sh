#!/usr/bin/bash
sudo yum install -q -y yum-utils
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
yum -y install docker docker-ce docker-ce-cli containerd.io
if [[ $? -eq 0 ]]; then
  echo "Docker installataion succeeded"
else
  echo "Docker installation failed"
fi
sudo yum install -y java-1.8.0-openjdk-devel
curl --silent --location http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo | sudo tee /etc/yum.repos.d/jenkins.repo
sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
sudo yum -y install jenkins
if [[ $? -eq 0 ]]; then
  echo "Jenkins installation succeeded"
else
  echo "Jenkins installation failed"
fi
