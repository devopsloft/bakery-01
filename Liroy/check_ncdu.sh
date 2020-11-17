#!/usr/bin/env bash

if [ "$(id -un)" != "root" ]; then
  echo "sudoing.."
  exec sudo "$0" "$@" || echo "You do not have root permission!" && exit 1
fi

yum list installed | grep ncdu
if [[ $? -eq 0 ]]; then
  echo "ncdu is installed. Goodbye"
  exit 0
fi

read -p "ncdu is not installed on your machine. Would you like to install it? [y/n]" user_answer
if [[ $user_answer == "y" ]]; then
  echo "Installing ncdu..."
  yum install -y ncdu && echo "ncdu installed successfully. Goodbye!"
elif [[ $user_answer == "n" ]]; then
  echo "Goodbye"
else
  echo "Invalid answer was given. Exiting..."
fi

