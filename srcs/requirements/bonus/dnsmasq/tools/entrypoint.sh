#!/bin/sh

# Generate /etc/hosts-dnsmasq
echo "192.168.1.10 takira.42.fr" > "/etc/hosts-dnsmasq"
echo "192.168.1.10 takira.hugo.com" >> "/etc/hosts-dnsmasq"

exec "$@"
