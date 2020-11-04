#!/usr/bin/env bash

which ncdu > /dev/null 2>&1
if [[ $? -eq 1 ]]; then	
    echo "Ncdu is not currently installed on Linux, are you interested in installing it? select the option that you prefer[Y/N]"
    read answer
    if [[ $answer = "Y" ]]; then
        echo "Installing ncdu"
        yum install -y epel-release
       # yum provides ncdu 
        yum install -y ncdu
    elif [[ $answer = "N" ]]; then
        echo "Ncdu not installed."
    else 
        echo "User chose invalid character..."
    fi
else 
    echo "Ncdu already installed"
fi
