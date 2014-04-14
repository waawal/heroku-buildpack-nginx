#!/usr/bin/env bash

set -x

CONFIG_FILE=nginx.conf.parsed

#Evaluate config to get $PORT
if [ -f nginx.conf ]
then
    erb /app/nginx.conf > ${CONFIG_FILE}
else
    erb /app/config/nginx.conf.erb > ${CONFIG_FILE}
fi

#Start log redirection.
(
	#Initialize log directory.
	mkdir -p logs/nginx
	touch logs/nginx/access.log logs/nginx/error.log

	#Redirect NGINX logs to stdout.
	echo 'buildpack=nginx at=logs-initialized'
	tail -qF -n 0 logs/nginx/*.log
) &

#Start NGINX
#We expect nginx to run in foreground.
echo 'buildpack=nginx at=nginx-start'
nginx -p . -c ${CONFIG_FILE}