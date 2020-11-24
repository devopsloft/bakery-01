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
echo "installing docker compose"
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo curl -L https://raw.githubusercontent.com/docker/compose/1.27.4/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version


