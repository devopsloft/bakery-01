#!/bin/bash
echo "removing old docker"
yum -y remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine \
		  docker-ce \
		  docker-ce-cli \
		  containerd.io \

echo "installing new docker"
yum install -y yum-utils
yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo;
yum install -y docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker $USER
echo "enable docker startup"
systemctl enable docker
echo "starting docker" 
systemctl start docker
