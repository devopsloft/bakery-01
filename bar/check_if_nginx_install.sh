#!/usr/bin/bash
if [[ $? -eq 0 ]]; then
  read -p "nginx is already installed. uninstall it? [y/n]" user_ans
  if [[ $user_ans == "y" ]]; then
    echo "Uninstalling nginx..."
    systemctl stop nginx.service
    systemctl disable nginx.service
    userdel -r nginx
    rm -rf /etc/nginx
    rm -rf /var/log/nginx
    rm -rf /var/cache/nginx/
    rm -rf /usr/lib/systemd/system/nginx.service
    yum erase -y nginx
  elif [[ $user_answer == "n" ]]; then
    echo "Goodbye"
  else
    echo "Invalid answer"
  fi
else
  read -p "nginx is not installed.install it? [y/n]" user_ans
  if [[ $user_answer == "y" ]]; then
    yum install -y epel-release nginx
    systemctl enable nginx && systemctl start nginx
  elif [[ $user_answer == "n" ]]; then
    echo "Nothing to do"
  else
    echo "Invalid answer"
  fi
fi
