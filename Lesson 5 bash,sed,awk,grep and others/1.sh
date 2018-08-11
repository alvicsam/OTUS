#!/bin/bash

while true; do
    nginx_status=$(systemctl is-active nginx)
    echo "nginx is in $nginx_status state"
    if [ $nginx_status != "active" ] ;then
	echo "something is terribly wrong!"
	sudo systemctl start nginx
	nginx_status=$(systemctl is-active nginx)
	echo "But now everything is ok and nginx is in $nginx_status state"
    fi
    sleep 1
done
