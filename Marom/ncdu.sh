#!/bin/bash
#This script installs ncdu if not installed, after verifying with the user.

if which ncdu > /dev/null 2>&1
then
    echo "ncdu is installed"
    $ncdu_status == "0"
else
    echo "ncdu does not exist on this machine"
    $ncdu_status == "1"
    echo -e "Install? (y/n) \c"

if "$REPLY" = "y"; then

      sudo yum install -y ncdu
      sudo systemctl start ncdu
      sudo systemctl enable ncdu
   fi
fi
<<<<<<< HEAD

=======
>>>>>>> 31d9676d247680e85c30e2f1736a88d81738855b
