#!/usr/bin/env bash

CONFIG_FILE=nginx.conf.parsed

#Evaluate config to get $PORT
if [ -f nginx.conf ]
then
    erb nginx.conf > ${CONFIG_FILE}
else
    erb config/nginx.conf.erb > ${CONFIG_FILE}
fi

#Start log redirection.
(
	#Initialize log directory.
	mkdir -p ${NGINX_BASE_DIR}/logs/nginx
	touch ${NGINX_BASE_DIR}/logs/nginx/access.log ${NGINX_BASE_DIR}/logs/nginx/error.log
	#Redirect NGINX logs to stdout.
	echo 'buildpack=nginx at=logs-initialized'
	tail -qF -n 0 ${NGINX_BASE_DIR}logs/nginx/*.log
) &

#Start NGINX
#We expect nginx to run in foreground.
echo 'buildpack=nginx at=nginx-start'
nginx -p . -c ${CONFIG_FILE}