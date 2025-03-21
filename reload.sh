#!/bin/bash
# This is a safe, hot-reload script that will minimize downtime between reloads and check your config changes.
#docker cp haproxy.cfg haproxy-proxy-1:/usr/local/etc/haproxy/haproxy_new.cfg
#docker exec haproxy-proxy-1 cp /usr/local/etc/haproxy/haproxy_new.cfg /usr/local/etc/haproxy/haproxy.cfg

check=$(docker compose run proxy-checker -c -f /usr/local/etc/haproxy/haproxy.cfg | grep valid)

if [ -z "$check" ]
then
      echo "Config check failed. Printing error information here:"
      docker compose run proxy-checker -c -f /usr/local/etc/haproxy/haproxy.cfg
else
      docker kill -s HUP haproxy-proxy-1
fi

