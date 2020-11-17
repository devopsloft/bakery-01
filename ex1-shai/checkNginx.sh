#!/usr/bin/env bash

which nginx > /dev/null 2>&1
if [[ $? -eq 1 ]]; then	
    echo "Nginx is not currently installed on Linux, Begins installation."
    yum install -y nginx
    useradd --no-create-home nginx
    systemctl enable nginx
    systemctl start nginx
    systemctl is-active --quiet nginx && echo Nginx is running
else
    echo "Nginx already installed"
    echo "Did you interested in uninstall it? select the option that you prefer[Y/N]"
    read answer
    if [[ $answer = "Y" ]]; then
        echo "Start remove nginx."
        systemctl stop nginx
        systemctl disable nginx
        userdel -r nginx
        
        rm -rf /etc/nginx /var/log/nginx /var/cache/nginx /usr/lib/systemd/system/nginx.servic

        yum remove -y nginx
    elif [[ $answer = "N" ]]; then
        echo "nginx has not been deleted"
    else
        echo "User chose invalid character...."
    fi
fi
