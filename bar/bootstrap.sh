#this scripts need's to run as root
#!/usr/bin/bash
yum -y install git
ssh-keygen -t rsa -b 4096
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
ssh -T git@github.com
yum install -q -y yum-utils
yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
yum -y install docker docker-ce docker-ce-cli containerd.io
systemctl enable docker
yum -y install lsof
sed -i "266i jenkins-port    8080/tcp                        #Application_Jenkins" /etc/services
firewall-cmd --zone=public --add-port=8080/tcp --permanent
firewall-cmd --reload
docker run -d -v jenkins_home:/var/jenkins_home -p 8080:8080 -p 50000:50000 jenkins/jenkins:lts
docker exec -u root -it laughing_engelbart /bin/bash
cat /var/jenkins_home/secrets/initialAdminPassword
