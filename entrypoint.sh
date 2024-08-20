#!/bin/bash

#	Try to connect to mysql 3 times
ATTEMPTS=12
#	Wait 5 secconds before trying to reconnect
INTERVAL=5

function getRandom() {
	dd if=/dev/urandom bs=32768 count=1 2>/dev/null | openssl sha512  | grep stdin | cut -d " " -f2 | cut -c1-64
}

if [ -n "$MYSQL_ENV_MYSQL_ROOT_PASSWORD" ]
then
	MYSQL_ROOT_PASSWORD="$MYSQL_ENV_MYSQL_ROOT_PASSWORD"
fi

if [ -n "$MYSQL_ENV_MYSQL_USER" ]
then
	MYSQL_USER="$MYSQL_ENV_MYSQL_USER"
fi

if [ -n "$MYSQL_ENV_MYSQL_PASSWORD" ]
then
	MYSQL_PASSWORD="$MYSQL_ENV_MYSQL_PASSWORD"
fi

if [ -n "$MYSQL_ENV_MYSQL_DATABASE" ]
then
	MYSQL_DB="$MYSQL_ENV_MYSQL_DATABASE"
fi

if [ -n "$MYSQL_PORT_3306_TCP_ADDR" ]
then
	MYSQL_HOST="$MYSQL_PORT_3306_TCP_ADDR"
fi

if [ -z "$MYSQL_HOST" ]
then
	MYSQL_HOST="mysql"
fi

if [ -z "$MYSQL_DB" ]
then
	MYSQL_DB="hashtopolis"
fi

if [ -z "$MYSQL_PORT" ]
then
	MYSQL_PORT="3306"
fi

if [ ! -z "$MYSQL_ROOT_PASSWORD" ]
then
	MYSQL_USER="root"
	MYSQL_PASSWORD=$MYSQL_ROOT_PASSWORD
fi


if [ '!' -f /var/www/html/inc/conf.php ]
then
	cp -rd /var/www/conf.php /var/www/inc/* /var/www/inc/.gitignore /var/www/html/inc
	rm -rf /var/www/inc /var/www/conf.php
#	CHECK MYSQL AVAILABILITY
	MYSQL="mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -h$MYSQL_HOST"
	$MYSQL -e "SELECT 'PING';" &>/dev/null
	ERROR=$?

	while [ $ERROR -ne 0 -a $ATTEMPTS -gt 1 ]
	do
		ATTEMPTS=$(($ATTEMPTS-1))
		echo "Failed connecting to the database.... Sleeping 5s and retrying $ATTEMPTS more."
		sleep $INTERVAL
		$MYSQL -e "SELECT 'PING';" &>/dev/null
		ERROR=$?
	done

	if [ $ERROR -ne 0 ]
	then
		echo "Could not connect to mysql. Please double check your settings and mysql's availability."
		echo "Used: $MYSQL"
		exit 20
	fi

#	CREATE DB
	$MYSQL -e "CREATE database $MYSQL_DB;"
#	APPEND DB
	MYSQL="$MYSQL $MYSQL_DB"
	if [ $? -ne 0 ]
	then
		echo "Failed to create the database... insufficient access??? already exists??? this shouldn't happen, I'm doing setup..."
		exit 21
	fi
#	IMPORT DB
	$MYSQL < /var/www/html/install/hashtopolis.sql
	if [ $? -ne 0 ]
	then
		echo "DB Import Failed!!!"
		exit 12
	fi
#	CONFIGURE DB
#	RUN SETUP & ADD USER
sed -i -e "s/MYSQL_USER/$MYSQL_USER/" -e "s/MYSQL_PASSWORD/$MYSQL_PASSWORD/" -e "s/MYSQL_DB/$MYSQL_DB/" -e "s/MYSQL_HOST/$MYSQL_HOST/" /var/www/html/inc/conf.php || exit 8
#	-e "s/MYSQL_PORT/$MYSQL_PORT/"  <--- fails and I don't get why...
#	CREATE USER & PASSWORD
if [ -z "$H8_USER" ]
then

	H8_USER=$(getRandom)
	echo -e "No login provided, generating random username:\n\t$H8_USER\n\nIf you don't like it, check the docs first, this is for your own security. admin/admin on a cracking tool sounds a bit funny.\n"
fi

if [ -z "$H8_PASS" ]
then
	H8_PASS=$(getRandom)
	echo -e "Your random password is: $H8_PASS\n\n\n"
fi

sed -i -e "s/H8_USER/$H8_USER/" -e  "s/H8_PASS/$H8_PASS/" -e "s/H8_EMAIL/$H8_EMAIL/" /var/www/html/install/adduser.php

/usr/bin/php /var/www/html/install/adduser.php

#	PHP MAIL SETTINGS
if [ -n "$PHP_MAIL_HOST" ]
then
	sed -i "s/^SMTP.*/SMTP = $PHP_MAIL_HOST/" /etc/php/7.2/apache2/php.ini
fi


if [ -n "$PHP_MAIL_PORT" ]
then
	sed -i "s/^smtp_port.*/smtp_port = $PHP_MAIL_PORT/" /etc/php/7.2/apache2/php.ini
fi


if [ -n "$PHP_MAIL_FROM" ]
then
	sed -i "s/^;sendmail_from.*/sendmail_from = $PHP_MAIL_FROM/" /etc/php/7.2/apache2/php.ini
fi


echo "Setup finished, pruning /install folder!"
	rm -rf /var/www/html/install
fi

#       HASHTOPOLIS FILE SETTINGS
if [ -n "$HTP_MEMORY_LIMIT" ]
then
        sed -i "s/^memory_limit.*/memory_limit = $HTP_MEMORY_LIMIT/" /etc/php/7.2/apache2/php.ini
fi


if [ -n "$HTP_UPLOAD_MAX_SIZE" ]
then
        sed -i "s/^upload_max_filesize.*/upload_max_filesize = $HTP_UPLOAD_MAX_SIZE/" /etc/php/7.2/apache2/php.ini
        sed -i "s/^post_max_size.*/post_max_size = $HTP_UPLOAD_MAX_SIZE/" /etc/php/7.2/apache2/php.ini
fi

#       ALLOW OVERRIDE ALL IN APACHE (AKA Enable .htaccess)
sed -i '/DocumentRoot/a \\t<Directory /var/www/html>\n\t\tAllowOverride All\n\t</Directory>' /etc/apache2/sites-available/000-default.conf

if [ -n "$HTP_SERVER_NAME" ]
then
        sed -i "s/#ServerName.*/ServerName $HTP_SERVER_NAME/" /etc/apache2/sites-available/000-default.conf
fi

chmod -R 777 /var/www/html/
/usr/sbin/apachectl -DFOREGROUND
