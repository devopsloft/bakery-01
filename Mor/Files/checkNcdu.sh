#!/bin/bash
#Install ncdu
which ncdu 
if [[ $? -eq 1 ]]; then	
    echo "Want to install Ncdu?[Y/N]"
    read userAnswer
    if [[ $userAnswer = "Y" ]]; then
        sudo yum update -y
        sudo yum install -y epel-release
        sudo yum install ncdu -y
    elif [[ $userAnswer = "N" ]]; then
        echo "Ncdu not installed."
    else 
        echo "invalid character"
    fi
else 
    echo "Ncdu installed"
fi
