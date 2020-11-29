#!/usr/bin/env bash
#This script installs and configures Jenkins + necessary plugins.

which docker > /dev/null 2>&1
#If docker isn't installed - the script installs it.
if [[ $? -eq 1 ]]; then
        yum update -y
        yum install -q -y yum-utils
              yum-config-manager \
              --add-repo \
        https://download.docker.com/linux/centos/docker-ce.repo
		echo "Installing Docker"
        yum -y install docker docker-ce docker-ce-cli containerd.io
        systemctl enable docker
        systemctl start docker
        
		systemctl is-active --quiet docker && echo Docker is running
		echo "Docker has been installed and activated!"
else
        echo "Docker is already installed on this system."
fi

#If the container already up, there is no need to set it up again.
docker container inspect jenkins_docker > /dev/null 2>&1
if [[ $? -eq 1 ]]; then
	echo "Jenkins is not installed. Installing it now."
	echo "FROM jenkins/jenkins:lts
	COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
	RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
	COPY casc.yaml /var/jenkins_home/casc.yaml
	ENV CASC_JENKINS_CONFIG /var/jenkins_home/casc.yaml
	ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false" > Dockerfile
        docker build -t jenkins:jcasc .
	docker run -d --name jenkins_docker --rm -p 8080:8080 --env JENKINS_ADMIN_ID=admin --env JENKINS_ADMIN_PASSWORD=password jenkins:jcasc		
else
        echo "Jenkins has been installed!"
fi

