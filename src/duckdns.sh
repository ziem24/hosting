#!/bin/sh

. "$dns_conf"
addr=$(curl -s ifconfig.me)

response=$(curl -k -s "https://www.duckdns.org/update?domains=$domain&token=$token&ip=$addr")
echo "DuckDNS response: $response"
