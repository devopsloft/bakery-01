#!/bin/bash
echo "Bootstrap Installtion Script"
echo "Installing yum utils"
sudo yum install -y yum-utils
echo "Installing git"
sudo yum install -y git
echo "Generating Keypair for GitHub - If a key already exist - you will be asked for replacement"
ssh-keygen -t rsa -f ~/.ssh/id_rsa -q -P ""
ssh-keygen -y -f ~/.ssh/id_rsa > ~/.ssh/id_rsa.pub
cat ~/.ssh/id_rsa.pub
read -p "Please Configure the ssh-rsa to your GitHub Account - once finished press Enter"
echo "Connect Github Repo - Answer Yes for Thumbprint"
ssh -T git@github.com
echo "Adding Docker Repo and Installing Docker"
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo;
sudo yum install -y docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker $USER
sudo systemctl start docker
sudo systemctl enable docker
echo "Docker installation Done"
echo "Installing Jenkins Container"
docker pull jenkins/jenkins
docker network create jenkins
docker volume create jenkins-docker-certs
docker volume create jenkins-data
docker container run --name jenkins-docker --rm --detach --privileged --network jenkins --network-alias docker --env DOCKER_TLS_CERTDIR=/certs --volume jenkins-docker-certs:/certs/client --volume jenkins-data:/var/jenkins_home --publish 2376:2376 docker:dind
echo "Exposing docker to port 11000 on Local Machine"
docker container run --name jenkins --rm --detach --network jenkins --env DOCKER_HOST=tcp://docker:2376 --env DOCKER_CERT_PATH=/certs/client --env DOCKER_TLS_VERIFY=1 --volume jenkins-data:/var/jenkins_home --volume jenkins-docker-certs:/certs/client:ro -p 11000:8080 jenkins/jenkins

