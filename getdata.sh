#!/bin/bash
# getdata.sh
# Mano Mishra : SEIS 665 : Fall2018 : UST
#
who=`whoami`

if [ $who != "root" ] 
then
	echo $who
	echo	"please use sudo ${0} [ options ] to run this command"
	exit 1
fi
#
#aws autoscaling describe-scaling-activities --auto-scaling-group-name wordpress-web-group > activity.json
# run this outside og the script. It's working on the command line, but from this script, it
# complains : you must specify region ....etc


cp /var/www/html/wordpress/wp-config.php .
cp /var/log/httpd/access_log .

