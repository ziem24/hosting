duckdns() {
    local addr=$(curl -s ifconfig.me)
    local response=$(curl -k -s "https://www.duckdns.org/update?domains=$domain&token=$token&ip=$addr")

    echo "DuckDNS response: $response"
}
