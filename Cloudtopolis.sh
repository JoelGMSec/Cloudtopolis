#!/bin/bash
#=====================================#
#   Cloudtopolis v3.0 by @JoelGMSec   #
#   https://darkbyte.net - [Server]   #
#=====================================#

clear -x
echo -ne "\033]0;Cloudtopolis v3.0 [Server] - by @JoelGMSec\007"
echo -e "\e[34;1m
   ____ _                 _ _                    _ _
  / ___| | ___  _   _  __| | |_ ___  _ __   ___ | (_)___
 | |   | |/ _ \| | | |/ _' | __/ _ \| '_ \ / _ \| | / __|
 | |___| | (_) | |_| | (_| | || (_) | |_) | (_) | | \__ \\
  \____|_|\___/ \__,_|\__,_|\__\___/|  __/ \___/|_|_|___/
                                    |_|

\e[37;1m:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: \e[34;1mCreated by @JoelGMSec \e[37;1m:: \e[34;1mhttps://darkbyte.net \e[37;1m:: \e[34;1mv3.0 \e[37;1m::
:: \e[34;1mhttps://github.com/JoelGMSec/Cloudtopolis \e[37;1m:: \e[31;1m[Server] \e[37;1m::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
echo -e "\e[0m"
echo -e "\e[32;1m[+] Checking Environment..\e[37;1m"

if curl 169.254.169.254 &> /dev/null ; then

AzureCloud="$(curl -s -H Metadata:true http://169.254.169.254/metadata/instance/network/interface/0/ipv4/ipAddress/0/publicIpAddress?api-version=2017-08-01&format=text)"
AmazonCloud="$(curl -s http://169.254.169.254/1.0/meta-data/local-ipv4)"
GoogleCloud="$(curl -s -H 'Metadata-Flavor: Google' http://169.254.169.254/computeMetadata/v1/instance/network-interfaces/0/access-configs/0/external-ip)"

AzureCheck="$(echo $AzureCloud | grep 404)"
AmazonCheck="$(echo $AmazonCloud | grep 404)"
GoogleCheck="$(echo $GoogleCloud | grep 404)"

    if [[ ! $AzureCheck ]] ; then
        echo -e "\e[37;1mAzure Cloud detected!"
        IP="$(echo $AzureCloud)"

    elif [[ ! $AmazonCheck ]] ; then
        echo -e "\e[37;1mAmazon Cloud detected!"
        IP="$(echo $AmazonCloud)"

    elif [[ ! $GoogleCheck ]] ; then
        echo -e "\e[37;1mGoogle Cloud detected!"
        IP="$(echo $GoogleCloud)"
    fi

else
    echo -e "\e[37;1mCustom install detected!"
    IP="$(curl -s ipconfig.io)"
    CustomVPS="True"
fi

echo -e "\e[0m"
echo -e "\e[32;1m[+] Checking Docker installation..\e[37;1m"

if docker -v &> /dev/null ; then
    if ! (( $(ps -ef | grep -v grep | grep docker | wc -l) > 0 )) ; then
        sudo service docker start > /dev/null 2>&1
        sleep 2
        echo -e "\e[37;1mDocker is installed and running!"
    else
        echo -e "\e[37;1mDocker is installed and running!"
    fi

else
    echo -e "\e[37;1mDocker is not installed!"
    echo -e "\e[0m"
    echo -e "\e[32;1m[+] Installing Docker Community Edition..\e[37;1m"

    sudo apt install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y -qq > /dev/null 2>&1
    curl -fsSL https://download.docker.com/linux/debian/gpg > apt.key ; sudo apt-key add apt.key > /dev/null 2>&1 ; rm apt.key > /dev/null 2>&1
    sudo echo "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
    sudo apt-get update > /dev/null 2>&1 ; sudo apt-get remove docker docker-engine docker.io -y -qq > /dev/null 2>&1
    sudo apt-get install docker-ce -y -qq > /dev/null 2>&1 ; sudo service docker start > /dev/null 2>&1
    echo -e "\e[37;1mDone!"
fi

sudo mkdir Cloudtopolis > /dev/null 2>&1 ; sudo mkdir Cloudtopolis/mysql > /dev/null 2>&1 ; sudo mkdir Cloudtopolis/inc > /dev/null 2>&1 ; sudo mkdir Cloudtopolis/import > /dev/null 2>&1 ; sudo mkdir Cloudtopolis/files > /dev/null 2>&1

if  sudo test -f "$(pwd)/Cloudtopolis/.creds" ; then
    RAND=$(cat Cloudtopolis/.creds)
else
    RAND=$(< /dev/urandom tr -dc 'A-Za-z0-9!@$' | fold -w 16 | head -n 1)
    sudo sh -c "echo -n $RAND > $(pwd)/Cloudtopolis/.creds"
fi

echo -e "\e[0m"
echo -e "\e[32;1m[+] Installing MySQL Database..\e[37;1m"
sudo docker run --rm --name mysql -v $(pwd)/Cloudtopolis/mysql:/var/lib/mysql -e MYSQL_ROOT_PASSWORD="$RAND" -d mysql:5.7 > /dev/null 2>&1
echo -e "\e[37;1mDone!"

docker tag  mysql:5.7 cloudtopolis/database > /dev/null 2>&1
docker rmi  mysql:5.7 > /dev/null 2>&1
CloudtopolisDB="$(pwd)/Cloudtopolis/mysql/sys"

echo -e "\e[0m"
echo -e "\e[32;1m[+] Installing Hashtopolis..\e[37;1m"
sudo docker build -t joelgmsec/cloudtopolis . > /dev/null 2>&1
sudo docker run --rm --name cloudtopolis --link mysql:mysql -v $(pwd)/Cloudtopolis/inc:/var/www/html/inc -v $(pwd)/Cloudtopolis/import:/var/www/html/import -v $(pwd)/Cloudtopolis/files:/var/www/html/files -e H8_USER="admin" -e H8_PASS="$RAND" -d -p 8000:80 joelgmsec/cloudtopolis > /dev/null 2>&1
echo -e "\e[37;1mDone!"

if [ ! -d $CloudtopolisDB ] ; then
    echo -e "\e[0m"
    echo -e "\e[31;1m[!] Cloudtopolis database not found!"
    sleep 1
    echo -e "\e[37;1mWait until setup is finished.."
    until [ -d $CloudtopolisDB ] ; do [ -d $CloudtopolisDB ] ; done

else
    echo -e "\e[0m"
    echo -e "\e[34;1m[i] Cloudtopolis database found!"
    sleep 1
    echo -e "\e[37;1mRestoring data from last session.."
    sleep 3
fi

if [[ $CustomVPS ]] ; then
   Link="http://localhost:8000"
fi

if [[ ! $CustomVPS ]] ; then
   LocalTunnelUP=$(curl --connect-timeout 3 -sk https://localtunnel.me)
   if [[ $LocalTunnelUP ]] ; then
      sudo apt install npm -y -qq > /dev/null 2>&1
      sudo npm install -g localtunnel > /dev/null 2>&1 ; sleep 3
      /bin/bash -c "lt --port 8000 > /tmp/localtunnel &" > /dev/null 2>&1 ; sleep 3
      Link=$(cat /tmp/localtunnel | awk '{print $4}')
   fi
   if [[ ! $Link ]] ; then
      rm -f ${HOME}/.ssh/localhost.run.rsa > /dev/null 2>&1
      /bin/sh -c "echo 'localhost.run ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC3lJnhW1oCXuAYV9IBdcJA+Vx7AHL5S/ZQvV2fhceOAPgO2kNQZla6xvUwoE4iw8lYu3zoE1KtieCU9yInWOVI6W/wFaT/ETH1tn55T2FVsK/zaxPiHZVJGLPPdEEid0vS2p1JDfc9onZ0pNSHLl1QusIOeMUyZ2bUMMLLgw46KOT9S3s/LmxgoJ3PocVUn5rVXz/Dng7Y8jYNe4IFrZOAUsi7hNBa+OYja6ceefpDvNDEJ1BdhbYfGolBdNA7f+FNl0kfaWru4Cblr843wBe2ckO/sNqgeAMXO/qH+SSgQxUXF2AgAw+TGp3yCIyYoOPvOgvcPsQziJLmDbUuQpnH' > ${HOME}/.ssh/localhost.run.known_hosts" > /dev/null 2>&1
      ssh-keygen -q -t rsa -b 2048 -q -N "" -f ${HOME}/.ssh/localhost.run.rsa > /dev/null 2>&1
      /bin/sh -c "ssh -t -o ServerAliveInterval=60 -o StrictHostKeyChecking=no -o UserKnownHostsFile=${HOME}/.ssh/localhost.run.known_hosts -o IdentitiesOnly=true -i "~/.ssh/localhost.run.rsa" -R "80:localhost:8000" localhost.run > /tmp/localhost.run < /dev/null 2>&1 &"
      sleep 3 ; Link="$(cat /tmp/localhost.run | awk '{ print $6 }' | grep http)"
   fi
fi

echo -e "\e[0m"
echo -e "\e[34;1m[i] Hashtopolis Credentials:"
echo -e "\e[31;1mUser: \e[37;1madmin"
echo -e "\e[31;1mPassword: \e[37;1m$RAND"
echo -e "\e[31;1mLink: \e[37;4m$Link\e[30m"
echo -e "\e[0m"
echo -e "\e[34;1m[i] Cloudtopolis is running!"
echo -e "\e[37;1mPress \e[31;1mControl+C \e[37;1mto stop.."
echo -e "\e[31;1m"

sudo chown -R 33:33 Cloudtopolis/inc Cloudtopolis/import Cloudtopolis/files
trap 'docker rm -f $(docker container ls -q -a) > /dev/null 2>&1 ; echo
echo -e "\e[31;1m[!] Control+C Pressed, exiting!\n\e[0m" ; exit' SIGINT SIGTERM
while true ; do sleep 3600 ; done
