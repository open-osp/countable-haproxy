#!/bin/bash
# This is a safe, hot-reload script that will minimize downtime between reloads and check your config changes.
check=$(docker-compose run proxy-checker -c -f /usr/local/etc/haproxy/haproxy.cfg | grep valid)

if [ -z "$check" ]
then
      echo "Config check failed. Printing error information here:"
      docker-compose run proxy-checker -c -f /usr/local/etc/haproxy/haproxy.cfg
else
      docker kill -s HUP haproxy_proxy_1
fi

