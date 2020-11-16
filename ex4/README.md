docker build -t jenkins:jcasc .
docker run --name myJ -u root -d -p 8085:8080 --env JENKINS_ADMIN_ID=admin --env JENKINS_ADMIN_PASSWORD=admin -v /home/shai/Documents/backery/playground/jcasc/JenkinsHomeNew:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock jenkins:jcasc
