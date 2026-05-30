#!/bin/sh

ROOT_DIR=$(cd "$(dirname "$0")" && pwd)
backups="$ROOT_DIR/backups"
servers="$ROOT_DIR/servers"
src="$ROOT_DIR/src"
config="$ROOT_DIR/main.conf"

choices_num=$(cat "$src/command_chooser.txt" | wc -l)

mkdir -p "$backups" "$servers"

if [ ! -e "$config" ]
then
	cp "$src/main.conf.empty" "$ROOT_DIR/main.conf"
	. "$ROOT_DIR/main.conf"
fi

list_servers() {
	local i=0
	for s in "$servers"/*
	do
		i=$(expr "$i" + 1)
		echo "    $i) $(basename $s)"
	done
}


get_server() {
	local server_idx=0
	echo "Choose a server:"
	list_servers
	echo "    q) Cancel choice"

	until  [ "$server_idx" = "q" ] || ([ "$server_idx" -ge 1 ] 2>/dev/null && [ "$server_idx" -le $(ls "$servers" | wc -l) ] 2>/dev/null)
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

. ./main.conf

echo "===================================================

Minecraft server utility for Linux
Ziemcorp INTERACTIVE COPYRIGHT 2026
"

while true
do
	echo 	"==================================================="
	echo 	"Choose a command: "
	cat 	"$src/command_chooser.txt"
	echo 	"    q) Finish work, I'm going to bed."
	until [ "$choice" = "q" ] || ([ "$choice" -ge 1 ] 2>/dev/null && [ "$choice" -le "$choices_num" ] 2>/dev/null) # || [ "$choice" = "h" ]
	do
		read -p "    >  " choice
	done
	echo 	"==================================================="
	echo
	case $choice in
		"1")
			echo "List of servers in the $(basename $servers) directory:"
			list_servers
			;;
		"2")
			get_server
			if [ "$server" != "" ]
			then
				backups=$backups servers=$servers "$src/start.sh" "$server"
			fi
			;;
		"3")  # todo
			echo "OOO" >&2
			;;
		"4")
			get_server
			if [ "$server" != "" ]
			then
				backups=$backups servers=$servers "$src/backup.sh" "$server"
			fi
			;;
		"5")  # todo
			echo "OOO" >&2
			;;
		"6")
			echo "Public IP address: $(curl -s ifconfig.me)"
			;;
		"7")
			config="$config" "$src/duckdns.sh"
			;;
		"8")
			"$edit" "$config" || echo "Editor is not configured properly" >&2
			. "$ROOT_DIR/main.conf"
			;;
		"9")
			read -p "Are you sure you want to reset your configuration file? [y/N]: " choice
			if [ "$choice" = "y" ]
			then
				cp "$src/main.conf.empty" "$ROOT_DIR/main.conf"
				. "$ROOT_DIR/main.conf"
			fi
			;;
		"10")
			"$src/fetch_versions.sh" > "$ROOT_DIR/versions.txt" && echo "Fetched to 'versions.txt'"
			;;
		"11")
			read -p "Choose version: " version
			config="$config" "$src/download.sh" "$version"
			;;
		"q")
			echo "Okay bye"
			break
			;;
	esac
	choice=""
done
