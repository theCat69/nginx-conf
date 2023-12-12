#!/bin/bash

rm -f $NGINX_CONF_PATH/nginx.conf
rm -f $NGINX_CONF_PATH/conf.d/https_server.conf

mv $NGINX_CONF_PATH/nginx.conf.bkp $NGINX_CONF_PATH/nginx.conf
mv $NGINX_CONF_PATH/conf.d/https_server.conf.bkp $NGINX_CONF_PATH/conf.d/https_server.conf
