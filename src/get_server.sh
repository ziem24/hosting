fn_get_server() {
	local server_idx=0
	local num_servers=$(ls "$servers" | wc -l)

	echo "Choose a server:"
	fn_list_dir "$servers" || { echo "No servers available. Cancelling" >&2; return 1; }
	echo "    q) Cancel choice"

	until [ "$server_idx" = "q" ] || ([ "$server_idx" -ge 1 ] 2>/dev/null && [ "$server_idx" -le "$num_servers" ] 2>/dev/null)
	do
		read -p "    > " server_idx
		: "${server_idx:=0}"
	done

	server=""
	if [ "$server_idx" != "q" ]
	then
		server=$(ls "$servers" | head -n "$server_idx" | tail -1)
	fi
}
