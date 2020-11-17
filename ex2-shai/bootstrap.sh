#!/usr/bin/env bash

which git > /dev/null 2>&1
if [[ $? -eq 1 ]]; then        
        yum install http://opensource.wandisco.com/centos/7/git/x86_64/wandisco-git-release-7-2.noarch.rpm
        yum install -y git
        git config --global user.name Shai Kamenker
        git config --global user.email kamenker92@gmail.com
	echo -e "\n"|ssh-keygen -t rsa -b 4096 -C "kamenker92@gmail.com" -N ""
else
        echo "git installed"
fi

which docker > /dev/null 2>&1
if [[ $? -eq 1 ]]; then        
        yum update -y 
        yum install -y yum-utils device-mapper-persistent-data lvm2
        yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
        echo "Installing docker....."
        yum install -y docker-ce docker-ce-cli containerd.io
        systemctl enable docker
        systemctl start docker

        systemctl is-active --quiet docker && echo Docker is running
else
        echo "docker installed"
fi

docker container inspect myjenkins > /dev/null 2>&1
if [[ $? -eq 1 ]]; then                
        echo "Installing jenkins"
        cd /home/Documents/shai/
        mkdir JenkinsHome
        chmod 755 JenkinsHome
        docker run --name myjenkins -u root -d -p 11000:8080 -v /home/Documents/shai/JenkinsHome:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock jenkins/jenkins       
else
        echo "jenkins installed"
fi
