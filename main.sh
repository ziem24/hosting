#!/bin/sh

ROOT=$(cd "$(dirname "$0")" && pwd)
backups="$ROOT/backups"
servers="$ROOT/servers"
src="$ROOT/src"
config="$ROOT/hosting.conf"
versions="$ROOT/versions.txt"

empty_config="$src/hosting_empty.conf"
command_chooser="$src/command_chooser.txt"

num_choices=$(expr $(cat "$src/command_chooser.txt" | wc -l) - 3)

mkdir -p "$backups" "$servers"

if [ ! -e "$config" ]
then
	cp "$empty_config" "$config"
fi

rmdir "$backups/*" 2>/dev/null

. "$config"
for function in "$src"/*.sh
do
	. "$function"
done


echo "===================================================

Minecraft server utility for Linux
Ziemcorp INTERACTIVE COPYRIGHT 2026
"

while true
do
	cat "$command_chooser"
	until [ "$choice" = "q" ] || ([ "$choice" -ge 1 ] 2>/dev/null && [ "$choice" -le "$num_choices" ] 2>/dev/null)
	do
		read -p "    > " choice
	done
	echo 	"==================================================="
	echo
	case $choice in
		"1")
			echo "List of servers in the $(basename "$servers") directory:"
			fn_list_dir "$servers" || echo "Empty directory!"
			;;
		"2")
			fn_get_server
			[ "$server" = "" ] || fn_start "$server"
			;;
		"3")  # todo
			fn_init
			;;
		"4")
			fn_get_server
			[ "$server" = "" ] || fn_backup "$server"
			;;
		"5")
			fn_load_from_backup
			;;
		"6")
		    echo "Public IP address: $(curl -s ifconfig.me || echo Unknown)"
			;;
		"7")
			fn_duckdns
			;;
		"8")
			"$edit" "$config" || echo "Editor is not configured properly" >&2
			. "$config"
			;;
		"9")
			read -p "Are you sure you want to reset your configuration file? [y/N]: " choice
			if [ "$choice" = "y" ]
			then
				cp "$empty_config" "$config"
				. "$config"
			fi
			;;
		"10")
			fn_fetch_versions > "$versions" && echo "Fetched to $(basename $versions)"
			;;
		"11")
			read -p "Choose version [q - cancel]: " version
			[ "x$version" = "xq" ] && echo "Action cancelled" || fn_download "$version"
			;;
		"q")
			echo "Okay bye"
			break
			;;
	esac
	choice=""
done
