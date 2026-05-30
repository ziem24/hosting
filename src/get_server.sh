get_server() {
	local server_idx=0
	echo "Choose a server:"
	list_servers
	echo "    q) Cancel choice"

	until [ "$server_idx" = "q" ] || ([ "$server_idx" -ge 1 ] 2>/dev/null && [ "$server_idx" -le $(ls "$servers" | wc -l) ] 2>/dev/null)
	do
		read -p "    > " server_idx
		: "${server_idx:=0}"
	done

	local server=""
	if [ "$server_idx" != "q" ]
	then
		local server=$(ls "$servers" | head -n "$server_idx" | tail -1)
	fi
}
