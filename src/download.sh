fn_download() {
	if [ ! -e "$versions" ]
	then
		echo "Versions text file not found, fetching..."
		fetch_versions 1>"$versions"
	fi

	if ! cat "$versions" | grep -q -x "$1"
	then
		echo "Unknown version: $1. Check spelling or refetch all versions." >&2
		return 1
	fi

	local download=$(curl -s "https://mcversions.net/download/$1" | tr ' ' '\n' | grep 'server.jar' | head -1 | sed 's/href=//g' | tr -d '\"')

	if [ -z "$download" ]; then
		echo "No server.jar found for version $1" >&2
		echo "Note: older versions may not provide server jars" >&2
		return 2
	fi

	wget "$download" -P "$download_dir" && echo "Saved to $download_dir"
}
