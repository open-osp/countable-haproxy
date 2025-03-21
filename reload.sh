#!/bin/bash
# This is a safe, hot-reload script that will minimize downtime between reloads and check your config changes.
docker compose cp haproxy.cfg proxy:/usr/local/etc/haproxy/haproxy_new.cfg
docker compose exec proxy cp /usr/local/etc/haproxy/haproxy_new.cfg /usr/local/etc/haproxy/haproxy.cfg

check=$(docker compose run proxy-checker -c -f /usr/local/etc/haproxy/haproxy.cfg | grep valid)

if [ -z "$check" ]
then
      echo "Config check failed. Printing error information here:"
      docker compose run proxy-checker -c -f /usr/local/etc/haproxy/haproxy.cfg
else
      docker compose kill -s HUP proxy
fi

