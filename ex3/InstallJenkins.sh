#!/usr/bin/env bash

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

docker container inspect myJenkins > /dev/null 2>&1
if [[ $? -eq 1 ]]; then                
        echo "Installing jenkins"
	mkdir -p /home/shai/Documents/backery/playground/jcasc/ex3/JenkinsHome
	chmod 755 /home/shai/Documents/backery/playground/jcasc/ex3/JenkinsHome
	cd /home/shai/Documents/backery/playground/jcasc/ex3/
	
	echo "Please enter the user name"
    	read userName	
	echo "Please enter the password"
	read Pass
	
	echo "
                git:latest
                github-api:latest
                workflow-aggregator:latest
                python:latest
                pipeline-github-lib:latest
                pipeline-stage-view:latest" > plugins.txt

	echo "
		unclassified:
		  location:
		    url: http://server_ip:8080/
		jenkins:
		  securityRealm:
		    local:
		      allowsSignup: false
		      users:
		       - id: ${JENKINS_ADMIN_ID}
		         password: ${JENKINS_ADMIN_PASSWORD}" > casc.yaml

	echo "
		FROM jenkins/jenkins:lts
		COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
		RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
		COPY casc.yaml /var/jenkins_home/casc.yaml
		ENV CASC_JENKINS_CONFIG /var/jenkins_home/casc.yaml
		ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false" > Dockerfile


	docker build -t jenkins:jcasc -f Dockerfile .
	docker run --name myJenkins -u root -d -p 8080:8080 --env JENKINS_ADMIN_ID=$userName --env JENKINS_ADMIN_PASSWORD=$Pass -v /home/shai/Documents/backery/playground/jcasc/ex3/JenkinsHome:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock jenkins:jcasc
else
        echo "jenkins installed"
fi

