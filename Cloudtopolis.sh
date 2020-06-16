#!/bin/bash
#######################################
#   Cloudtopolis v1.0 by @JoelGMSec   #
#        https://darkbyte.net         #
#######################################

clear
echo -e "\e[34;1m
   _______             ____                 __
  / ___/ /__  __ _____/ / /____  ___  ___  / /_ __
 / /__/ / _ \/ // / _  / __/ _ \/ _ \/ _ \/ / (_-<
 \___/_/\___/\_,_/\_,_/\__/\___/ .__/\___/_/_/___/
                              /_/            v1.0
\e[37;1m:::::::::::::::::::::::::::::::::::::::::::::::::::
:: \e[34;1mCreated by @JoelGMSec \e[37;1m:: \e[34;1mhttps://darkbyte.net \e[37;1m::
:::::::::::::::::::::::::::::::::::::::::::::::::::"
echo -e "\e[0m"
echo -e "\e[32;5;1m [+] Installing MySQL Database.."
echo -e "\e[0m"
docker run --name mydb -e MYSQL_ROOT_PASSWORD=Cl0udt0p0l1s! -d mysql:5.7
echo -e "\e[0m"
echo -e "\e[32;5;1m [+] Installing Hashtopolis.."
echo -e "\e[0m"
docker run --link mydb:mysql -e H8_USER="admin" -e H8_PASS="Cl0udt0p0l1s!" -d -p 1337:80 kpeiruza/hashtopolis
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
echo -e "\e[0m"
echo -e "\e[32;5;1m [+] Configuring SSH access.."
echo -e "\e[0m"
sudo service ssh restart
IP="$(curl -s -H "Metadata-Flavor: Google" http://metadata/computeMetadata/v1/instance/network-interfaces/0/access-configs/0/external-ip)" ; User="$(whoami)"
echo "$User:Cl0udt0p0l1s!" | sudo chpasswd -m
echo -e "\e[0m"
echo -e "\e[36;1m[i] Connect to Cloud Shell SSH:"
echo -e "\e[0;1mssh -L 1337:localhost:1337 $User@$IP -p 6000"
echo -e "\e[35;1m[!] Remember, the password is \e[35;3;1mCl0udt0p0l1s!"
echo -e "\e[0m"
echo -e "\e[36;1m[i] Hashtopolis credentials:"
echo -e "\e[35;1mUser: \e[0;1madmin"
echo -e "\e[35;1mPassword: \e[0;1mCl0udt0p0l1s!"
echo -e "\e[0m"
echo -e "\e[36;1m[i] Requeriments for Colaboratory:"
echo -e "\e[35;1mUser=\e[0;1m'$User'"
echo -e "\e[35;1mIP=\e[0;1m'$IP'"
echo -e "\e[35;1mVoucher=\e[0;1m'Create and copy from \e[4;1mlocalhost:1337/agents.php?new=true\e[0;1m'"
echo -e "\e[0m"
