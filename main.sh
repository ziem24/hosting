#!/bin/sh

ROOT_DIR=$(cd "$(dirname "$0")" && pwd)
backups="$ROOT_DIR/backups"
servers="$ROOT_DIR/servers"
src="$ROOT_DIR/src"
config="$ROOT_DIR/main.conf"
versions="$ROOT_DIR/versions.txt"

choices_num=$(cat "$src/command_chooser.txt" | wc -l)

mkdir -p "$backups" "$servers"

if [ ! -e "$config" ]
then
	cp "$src/main.conf.empty" "$config"
fi

. "$config"
for function in $src/*.sh
do
	. "$function"
done


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
				backup "$server"
			fi
			;;
		"5")  # todo
			echo "OOO" >&2
			;;
		"6")
			echo "Public IP address: $(curl -s ifconfig.me)"
			;;
		"7")
			duckdns
			;;
		"8")
			"$edit" "$config" || echo "Editor is not configured properly" >&2
			. "$config"
			;;
		"9")
			read -p "Are you sure you want to reset your configuration file? [y/N]: " choice
			if [ "$choice" = "y" ]
			then
				cp "$src/main.conf.empty" "$config"
				. "$config"
			fi
			;;
		"10")
			fetch_versions > "$ROOT_DIR/versions.txt" && echo "Fetched to 'versions.txt'"
			;;
		"11")
			read -p "Choose version: " version
			download "$version"
			;;
		"q")
			echo "Okay bye"
			break
			;;
	esac
	choice=""
done
