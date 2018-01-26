
#!/bin/sh

TOPDIR=`pwd`
CONF_FILE=nginx.conf.proxy

backend_server="192.168.1.199:80"

source scripts/profile

setup_proxy()
{
	if [ ! -f $NGINX_PATH/conf/$CONF_FILE ]; then
		cp conf/nginx/$CONF_FILE $NGINX_PATH/conf/
	fi
	#sed -i "s/backend_server/$backend_server/g" $NGINX_PATH/conf/nginx.conf
}

setup_proxy

# start nginx
$NGINX_PATH/sbin/nginx -s stop
sleep 1
$NGINX_PATH/sbin/nginx -c $NGINX_PATH/conf/$CONF_FILE
sleep 1
ps -ef | grep nginx | grep -v grep | grep -v "start-nginx" | wc -l

# stop nginx
#$NGINX_PATH/sbin/nginx -s stop

# reload nginx
#$NGINX_PATH/sbin/nginx -s reload
