#!/bin/sh

TOPDIR=`pwd`

backend_server="192.168.1.105:80"

source scripts/profile

setup_webserver()
{
	cp conf/nginx/nginx.conf.webserver $NGINX_PATH/conf/nginx.conf
}

setup_proxy()
{
	cp conf/nginx/nginx.conf.proxy $NGINX_PATH/conf/nginx.conf
	sed -i "s/backend_server/$backend_server/g" $NGINX_PATH/conf/nginx.conf
}

setup_lb()
{
	cp conf/nginx/nginx.conf.lb $NGINX_PATH/conf/nginx.conf
	sed -i "s/backend_server/$backend_server/g" $NGINX_PATH/conf/nginx.conf
}

setup_lb

# start nginx
$NGINX_PATH/sbin/nginx -s stop
sleep 1
$NGINX_PATH/sbin/nginx

sleep 1

ps -ef | grep nginx | grep -v grep | grep -v "start-nginx" | wc -l

# stop nginx
#$NGINX_PATH/sbin/nginx -s stop

# reload nginx
#$NGINX_PATH/sbin/nginx -s reload
