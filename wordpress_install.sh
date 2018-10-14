#!/bin/bash
#
# Mano Mishra : SEIS 665 : Fall2018 : UST
# wordpress_install.sh
#
# check to see if running as root :
who=`whoami`

if [ $who != "root" ] 
then
	echo $who
	echo	"please use sudo ${0} [ options ] to run this command"
	exit 1
fi

#step 1 : download wordpress
#
wget -O /var/www/html/wp.tar.gz https://wordpress.org/latest.tar.gz

if [ $? -eq 0 ]
then
	echo "wordpress downloaded successfully"
else
	echo " Error in downloading wordpress....please check "
	exit 1
fi

#Step 2 : Extract the gzip
echo "Extracting wordpres......"
tar xf /var/www/html/wp.tar.gz -C /var/www/html

if [ $? -eq 0 ]
then
	echo "wordpress extracted  successfully"
else
	echo " Error in extracting wordpress....please check "
	exit 1
fi

#Step 3: remove the tar

rm -f /var/www/html/wp.tar.gz

if [ $? -eq 0 ]
then
	echo "wordpress tar removed   successfully"
else
	echo " Error in removing wordpress tar....please check "
	exit 1
fi

#Step 4 :

 cp /var/www/html/wordpress/wp-config-sample.php  /var/www/html/wordpress/wp-config.php

#Step 5 :
sed 's/database_name_here/wordpress/'  -i /var/www/html/wordpress/wp-config.php
sed 's/username_here/wpadmin/'  -i /var/www/html/wordpress/wp-config.php
sed 's/password_here/SEISMano2018/'  -i /var/www/html/wordpress/wp-config.php
sed 's/localhost/wordpressdb.cw31kksjbzly.us-west-2.rds.amazonaws.com/'  -i /var/www/html/wordpress/wp-config.php
#
#Step 6 :

sed '/Directory \"\/var\/www\/html/,/AllowOverride None/s/AllowOverride None/AllowOverride All/' -i /etc/httpd/conf/httpd.conf

#
#Step 7 :
#
groupadd www
usermod -a -G www apache
chown -R apache:www /var/www
chmod 2775 /var/www
find /var/www -type d -exec chmod 2775 {} \;
find /var/www -type f -exec chmod 0664 {} \;
#
# Step 8 :
#
systemctl restart httpd.service
#
if [ $? -eq 0 ]
then
	echo "httpd services re started successfully"
else
	echo " Error in re-starting httpd services.....please check "
	exit 1
fi
#site title Assignment5
#username : mano
#passwd : mishra2018

