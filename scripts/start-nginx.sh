#!/usr/bin/env bash

echo 'buildpack=nginx at=nginx-start-begin'

# fail fast
set -e

CONFIG_FILE=nginx.conf.parsed

# Filter config file usng erb to get $PORT
if [ -f nginx.conf.erb ]
then
    erb nginx.conf.erb > ${CONFIG_FILE}
elif [ -f config/nginx.conf.erb ]
then
    erb config/nginx.conf.erb > ${CONFIG_FILE}
else
    echo 'buildpack=nginx at=nginx-start-fail'
    echo 'no suitable config found'
    exit 1
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

# Start NGINX
# We expect nginx to run in foreground so ...
# 1) the 'daemon off' directive should be set in the config file
# 2) we use -p . to ensure that we don't use the default prefix from the build process


( nginx -p . -c ${CONFIG_FILE} ) &

running=$(ps -ef | grep nginx)

if [ -n ${running} ]
then
    echo 'buildpack=nginx at=nginx-start-complete'
    exit 0
else
    echo 'buildpack=nginx at=nginx-start-not-starting'
    exit 1
fi