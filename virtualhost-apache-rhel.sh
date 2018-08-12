#! /bin/bash

# A Bash script which automates the process of creating Apache virtualhost configuration files and a document root directory. The script will 
# perform the necessary checks to accommodate first-time execution of the script on a server, as well as ensure that virtual host conflicts do 
# not occur.

# Variables

VHOSTNAME=$1
TIER=$2

# Other Variables

HTTPDCONF=/etc/httpd/conf/httpd.conf
VHOSTCONFDIR=/etc/httpd/conf.d # Another way to use /etc/httpd/conf.vhosts.d
DEFVHOSTCONFFILE=$VHOSTCONFDIR/00-default-vhost.conf
VHOSTCONFFILE=$VHOSTCONFDIR/$VHOSTNAME.conf
WWWROOT=/srv
DEFVHOSTDOCROOT=$WWWROOT/default/www
VHOSTDOCROOT=$WWWROOT/$VHOSTNAME/www

# Check arguments
if [ "$VHOSTNAME" = '' -o "$TIER" = '' ]; 
then
	echo "Usage: $0 VHOSTNAME TIER"
	exit 1
else
# Set support email address
case $TIER in

	1) VHOSTADMIN="basic_support@example.com"
	   ;;
	2) VHOSTADMIN="business_support@example.com"
	   ;;
	3) VHOSTADMIN="enterprise_support@example.com"
	   ;;
	*) echo "Invalid tier specified."
	   exit 1
	   ;;
esac
fi


#### I used existing default directory to put my vhost *.conf file. 
#### See above in other variable name, VHOSTCONFDIR. Then you can understand.
#### Another way for functioning *.conf file by creating new directory like /etc/httpd/conf.vhosts.d
#### You can use default /etc/httpd/conf.d/ directory, otherwise follow this statement below:


# Create conf directory one time if non-existent

# if [ ! -d $VHOSTCONFDIR ]; then
#	mkdir $VHOSTCONFDIR
#		if [ $? -ne 0 ]; then
#			echo "ERROR: Failed creating $VHOSTCONFDIR."
#			exit 1 # exit 1
#		fi
# fi



# Add include one time if missing

# grep -q '^IncludeOptional conf\.vhosts\.d/\*\.conf$' $HTTPDCONF
# if [ $? -ne 0 ]; 
# then
	# Backup before modifying
#	cp -a $HTTPDCONF $HTTPDCONF.orig
	
#	echo "IncludeOptional conf.vhosts.d/*.conf" >> $HTTPDCONF
		
#	if [ $? -ne 0 ]; then
#		echo "ERROR: Failed adding include directive."
#		exit 1
#	fi
# fi

# Verify if the default virtual host configuration file already exists and, if not. create and populate it with the following statement:

#cat <<DEFCONFEOF > $DEFVHOSTCONFFILE
#<VirtualHost _default_:80>
#	DocumentRoot $DEFVHOSTDOCROOT
#	CustomLog "logs/default-vhost.log" combined
#</VirtualHost>

#<Directory $DEFVHOSTDOCROOT>
#	Require all granted
#</Directory>
#DEFCONFEOF

# Check for default virtual host

if [ ! -f $DEFVHOSTCONFFILE ];
then
	cat <<DEFCONFEOF > $DEFVHOSTCONFFILE
<VirtualHost _default_:80>
	DocumentRoot $DEFVHOSTDOCROOT
	CustomLog "logs/default-vhost.log" combined
</VirtualHost>

<Directory $DEFVHOSTDOCROOT>
	Require all granted
</Directory>
DEFCONFEOF
fi

#Verify if the default virtual host document root directory already exists and, if not, create it.

if [ -d $DEFVHOSTDOCROOT ]; 
then
	mkdir -p $DEFVHOSTDOCROOT
	semanage fcontext -a -t httpd_sys_content_t "/srv(/.*)?"
	restorecon -Rv /srv/
fi

# Check for virtual host conflict

if [ -f $VHOSTCONFFILE ]; then
	echo "ERROR: $VHOSTCONFFILE already exists."
	exit 1
elif [ -d $VHOSTDOCROOT ]; then
	echo " ERROR: $VHOSTDOCROOT already exists."
	exit 1
else
	cat <<CONFEOF > $VHOSTCONFFILE
	<VirtualHost *:80>
		ServerName $VHOSTNAME
		ServerAdmin $VHOSTADMIN
		DocumentRoot $VHOSTDOCROOT
		ErrorLog "logs/${VHOSTNAME}_error_log"
		customLog "logs/${VHOSTNAME}_access_log" common
	</VirtualHost>

	<Directory $VHOSTDOCROOT>
		Require all granted
	</Directory>
CONFEOF

	mkdir -p $VHOSTDOCROOT
	semanage fcontext -a -t httpd_sys_content_t "/srv(/.*)?"
	restorecon -Rv /srv/
fi

# Check config and reload 

apachectl configtest &> /dev/null

if [ $? -eq 0 ]; then
	systemctl reload httpd &> /dev/null
else
	echo "ERROR: Config error."
	exit 1
fi

# This scripting file is used for automation of Virtualhost Configuration.
