#!/bin/bash
echo "Top 5 visitors"
gzip -c -d /var/log/nginx/wp-access.log.*.gz | awk '{print $1}' | sort | uniq -c | sort -r -n | head -n 5
echo
echo "Top 5 slowest requests for today"
#log_format in nginx.conf should be like this:
#    log_format main	'$remote_addr - $remote_user [$time_local] '
#		'"$request" $status $body_bytes_sent '
#		'"$http_referer" "$http_user_agent" '
#		'$request_time';
cat /var/log/nginx/access.log | awk '{print "time: " $23 " page: " $7 " visitors ip: "$1}' | sort -r | head -n 5