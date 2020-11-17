#!/usr/bin/bash
if [[ $? -eq 0 ]]; then
    echo "ncdu installed"
    exit 0
fi
read -p "ncdu is not install. do you want to install it ? [y/n]" user_ans
if [[ user_ans == "y" ]]; then
    yum install -y ncdu
elif [[ $user_ans == "n" ]];  then
    echo "not install it"
else
    echo "Invaild answer"
fi
