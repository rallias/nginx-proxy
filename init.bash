#!/bin/bash

if [ ! -e /etc/nginx/ssl/nginx.crt ]
then
  openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt -subj "/C=US/ST=District Of Colombia/L=Washington/O=NohbdySec/OU=Department of Security/CN=example.com"
fi

forego start -r
