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
	mkdir -p /app/logs/nginx
	touch /app/logs/nginx/access.log
	touch /app/logs/nginx/error.log

	#Redirect NGINX logs to stdout.
	echo 'buildpack=nginx at=logs-initialized'
	tail -qF -n 0 /app/logs/nginx/*.log
) &

#Start NGINX
#We expect nginx to run in foreground.
echo 'buildpack=nginx at=nginx-start'
nginx -c ${CONFIG_FILE}