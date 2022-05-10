#!/bin/bash

# begin as root
echo -e  "\033[31mthis script should run as root! \033[0m"

sleep 1

user=`whoami`

if [ $user = "root" ]
then
	echo "ok, you are root"
else
	echo "you are not root :)"
	exit 1
fi

apt-get install -y update
apt-get install -y aptitude
aptitude install -y sudo
aptitude install -y apt-transport-https
aptitude install -y ca-certificates
aptitude install -y curl
aptitude install -y software-propertirs-common
aptitude install -y make
aptitude install -y systemd
aptitude install -y ssh
aptitude install -y ufw
aptitude install -y apparmor
aptitude install -y git
aptitude install -y vim
aptitude install -y net-tools
aptitude install -y htop

exit 0
