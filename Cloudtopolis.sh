#!/bin/bash
#=====================================#
#   Cloudtopolis v2.4 by @JoelGMSec   #
#        https://darkbyte.net         #
#=====================================#

clear
echo -e "\e[34;1m
   ____ _                 _ _                    _ _ 
  / ___| | ___  _   _  __| | |_ ___  _ __   ___ | (_)___
 | |   | |/ _ \| | | |/ _' | __/ _ \| '_ \ / _ \| | / __|
 | |___| | (_) | |_| | (_| | || (_) | |_) | (_) | | \__ \\
  \____|_|\___/ \__,_|\__,_|\__\___/|  __/ \___/|_|_|___/
                                    |_|
\e[37;1m-----------------------------------------------------------
:: \e[34;1mCreated by @JoelGMSec \e[37;1m:: \e[34;1mhttps://darkbyte.net \e[37;1m:: \e[34;1mv2.4 \e[37;1m::
-----------------------------------------------------------"
echo -e "\e[0m"
echo -e "\e[32;1m[+] Checking Environment..\e[0;1m"

if ping -c 1 169.254.169.254 &> /dev/null ; then

AzureCloud="$(curl -s -H Metadata:true http://169.254.169.254/metadata/instance/network/interface/0/ipv4/ipAddress/0/publicIpAddress?api-version=2017-08-01&format=text)"
AmazonCloud="$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)"
GoogleCloud="$(curl -s -H 'Metadata-Flavor: Google' http://169.254.169.254/computeMetadata/v1/instance/network-interfaces/0/access-configs/0/external-ip)"

AzureCheck="$(echo $AzureCloud | grep 404)"
AmazonCheck="$(echo $AmazonCloud | grep 404)"
GoogleCheck="$(echo $GoogleCloud | grep 404)"

    if [[ ! $AzureCheck ]] ; then
	    echo -e "\e[0;1mAzure Cloud detected!"
	    IP="$(echo $AzureCloud)"

    elif [[ ! $AmazonCheck ]] ; then
	    echo -e "\e[0;1mAmazon Cloud detected!"
	    IP="$(echo $AmazonCloud)"

    elif [[ ! $GoogleCheck ]] ; then
	    echo -e "\e[0;1mGoogle Cloud detected!"
	    IP="$(echo $GoogleCloud)"
    fi

else
    echo -e "\e[0;1mCustom VPS detected!"
    IP="$(curl -s ipconfig.io)"
    CustomVPS="True"
fi

echo -e "\e[0m"
echo -e "\e[32;1m[+] Checking Docker installation..\e[0;1m"

if docker -v &> /dev/null ; then
	if not "$(service docker status | grep Active)" &> /dev/null ; then
    	sudo systemctl start docker	    
    else
        echo -e "\e[0;1mDocker is installed and running!"
    fi

else
    echo -e "\e[0;1mDocker is not installed!"
    echo -e "\e[0m"
    echo -e "\e[32;1m[+] Installing Docker Community Edition..\e[0;1m"
    
    curl -fsSL https://download.docker.com/linux/debian/gpg > apt.key ; sudo apt-key add apt.key > /dev/null 2>&1 ; rm apt.key > /dev/null 2>&1
    sudo echo 'deb [arch=amd64] https://download.docker.com/linux/debian buster stable' > /etc/apt/sources.list.d/docker.list
    sudo apt-get update > /dev/null 2>&1 ; sudo apt-get remove docker docker-engine docker.io -y -qq > /dev/null 2>&1
    sudo apt-get install docker-ce -y -qq > /dev/null 2>&1 ; sudo systemctl start docker > /dev/null 2>&1
    echo -e "\e[0;1mDone!"
fi

echo -e "\e[0m"
echo -e "\e[32;1m[+] Installing MySQL Database..\e[0;1m"
sudo docker run --name mydb -e MYSQL_ROOT_PASSWORD=Cl0udt0p0l1s! -d mysql:5.7

echo -e "\e[0m"
echo -e "\e[32;1m[+] Installing Hashtopolis..\e[0;1m"
sudo docker run --name hashtopolis --link mydb:mysql -e H8_USER="admin" -e H8_PASS="Cl0udt0p0l1s!" -d -p 8000:80 kpeiruza/hashtopolis

if [[ $CustomVPS ]] ; then

echo -e "\e[0m"
echo -e "\e[32;1m[+] Installing SSH Access..\e[0;1m"

SshDocker="$(docker image ls | grep kartoza)"

if [[ ! $SshDocker ]] ; then
sudo docker build --quiet -t kartoza/ssh git://github.com/timlinux/docker-ssh
fi

sudo docker run --name ssh --link hashtopolis:hashtopolis -p 2222:22 -d -t kartoza/ssh
sleep 3

SshHost="$(echo $IP)"
SshPort="2222"
SshUser="root"
SshPass="$(docker logs ssh | grep 'root login password' | awk '{print $4}' | tr -d "\n\r")"

echo -e "\e[0m"
echo -e "\e[36;1m[i] VPS Mode Data for Colab:\e[0;1m"
echo -e "VPS = True"
echo -e "SshHost = '$SshHost'"
echo -e "SshPort = '$SshPort'"
echo -e "SshUser = '$SshUser'"
echo -e "SshPass = '$SshPass'"

fi

echo -e "\e[0m"
echo -e "\e[36;1m[i] Hashtopolis Credentials:"
echo -e "\e[35;1mUser: \e[0;1madmin"
echo -e "\e[35;1mPassword: \e[0;1mCl0udt0p0l1s!"
echo -e "\e[35;1mUrl: \e[0;4;1mhttp://localhost:8000"
echo -e "\e[0m"
echo -e "\e[36;1m[i] Cloudtopolis is running!"
echo -e "\e[0;1mPress \e[35;1mCTRL+C \e[0;1mto stop.."
echo -e "\e[0m"

trap 'docker rm -f $(docker container ls -q -a) > /dev/null 2>&1 ; echo ; exit' SIGINT SIGTERM EXIT
while true ; do sleep 1 ; done
