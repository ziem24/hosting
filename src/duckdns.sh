fn_duckdns() {
    local addr=$(curl -s ifconfig.me)
    local response=$(curl -k "https://www.duckdns.org/update?domains=$domain&token=$token&ip=$addr")

    echo "DuckDNS response: $response"
}
