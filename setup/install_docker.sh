#!/bin/bash

echo -e  "\033[31mthis script should run as sudo! \033[0m"

FLAG=`groups | grep -x "sudo"`

sleep 1

if [[ FLAG -eq 0 ]]
then
        echo "ok, you are in sudo group"
else
        echo "check permission :)"
        exit 1
fi

# install docker
sudo apt-get install gnupg
sudo curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker.io
sudo chmod 666 /var/run/docker.sock
 
# install docker-compose
sudo aptitude install -y python3 python3-pip
sudo aptitude install libffi-dev
sudo pip3 install docker-compose
