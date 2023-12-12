#!/bin/bash

rm -f $NGINX_CONF_PATH/conf.d/https_server.conf.bkp
rm -f $NGINX_CONF_PATH/nginx.conf.bkp

mv $NGINX_CONF_PATH/conf.d/https_server.conf $NGINX_CONF_PATH/conf.d/https_server.conf.bkp 
mv $NGINX_CONF_PATH/nginx.conf $NGINX_CONF_PATH/nginx.conf.bkp  

cp ./conf.d/https_server.conf $NGINX_CONF_PATH/conf.d/https_server.conf
cp ./nginx.conf $NGINX_CONF_PATH/nginx.conf 
