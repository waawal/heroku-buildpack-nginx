#!/usr/bin/env bash

echo 'buildpack=nginx at=nginx-start-begin'

# fail fast
set -e

ROOT_DIR=/app

CONFIG_FILE=${ROOT_DIR}/nginx.conf.parsed

# Filter config file usng erb to get $PORT
if [ -f ${ROOT_DIR}/nginx.conf.erb ]
then
    erb ${ROOT_DIR}/nginx.conf.erb > ${CONFIG_FILE}
elif [ -f ${ROOT_DIR}/config/nginx.conf.erb ]
then
    erb ${ROOT_DIR}/config/nginx.conf.erb > ${CONFIG_FILE}
else
    echo 'buildpack=nginx at=nginx-start-fail'
    echo 'no suitable config found'
    exit 1
fi

mkdir -p ${ROOT_DIR}/logs
touch ${ROOT_DIR}/logs/access.log
touch ${ROOT_DIR}/logs/error.log

#Redirect NGINX logs to stdout.
echo 'buildpack=nginx at=logs-initialized'

#Start log redirection.
(
	#Redirect NGINX logs to stdout.
	echo 'buildpack=nginx at=logs-initialized'
	tail -qF -n 0 ${ROOT_DIR}/logs/*.log
) &

# Start NGINX
# We expect nginx to run in foreground so ...
# 1) the 'daemon off' directive should be set in the config file
# 2) we use -p . to ensure that we don't use the default prefix from the build process

nginx -p . -c ${CONFIG_FILE}