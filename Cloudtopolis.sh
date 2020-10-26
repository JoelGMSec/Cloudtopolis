#!/bin/bash
#=====================================#
#   Cloudtopolis v2.2 by @JoelGMSec   #
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
:: \e[34;1mCreated by @JoelGMSec \e[37;1m:: \e[34;1mhttps://darkbyte.net \e[37;1m:: \e[34;1mv2.2 \e[37;1m::
-----------------------------------------------------------"
echo -e "\e[0m"
echo -e "\e[32;5;1m [+] Installing MySQL Database.."
echo -e "\e[0m"

docker run --name mydb -e MYSQL_ROOT_PASSWORD=Cl0udt0p0l1s! -d mysql:5.7
echo -e "\e[0m"
echo -e "\e[32;5;1m [+] Installing Hashtopolis.."
echo -e "\e[0m"

docker run --link mydb:mysql -e H8_USER="admin" -e H8_PASS="Cl0udt0p0l1s!" -d -p 8000:80 kpeiruza/hashtopolis
echo -e "\e[0m"
echo -e "\e[36;1m[i] Hashtopolis credentials:"
echo -e "\e[35;1mUser: \e[0;1madmin"
echo -e "\e[35;1mPassword: \e[0;1mCl0udt0p0l1s!"
echo -e "\e[35;1mUrl: \e[0;4;1mhttp://localhost:8000"
echo -e "\e[0m"
echo -e "\e[36;1m[i] Cloudtopolis is running!"
echo -e "\e[0;1mPress \e[35;1mCTRL+C \e[0;1mto stop.."
echo -e "\e[0m"

trap 'docker rm -f $(docker container ls -q) > /dev/null 2>&1 ; echo ; exit' SIGINT SIGTERM EXIT
while true ; do sleep 1 ; done
