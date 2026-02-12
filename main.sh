#!/bin/sh

ROOT_DIR=$(cd "$(dirname "$0")" && pwd)
backups="$ROOT_DIR/backups"
jarfiles="$ROOT_DIR/jarfiles"
servers="$ROOT_DIR/servers"
src="$ROOT_DIR/src"
dns_conf="$ROOT_DIR/dns.conf"

mkdir "$backups" "$servers" "$jarfiles" 2>/dev/null

if [ ! -e "$dns_conf" ]
then
	echo "domain=
token=" > dns.conf
fi

[ "$edit" = "" ] && edit=vim
if ! which "$edit" 1>/dev/null
then
	exit 1
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

echo "====================================================

Minecraft server utility for Linux
Ziemcorp INTERACTIVE COPYRIGHT 2026
"

while true
do
	echo 	"==================================================="
	echo 	"Choose a command: "
	echo 	"    1) List servers"
	echo 	"    2) Start a server"
	echo 	"    3) Initialize a new server (OOO)"
	echo 	"    4) Create a backup"
	echo 	"    5) Load a backup (OOO)"
	echo	"    6) Show network information"
	echo	"    7) Configure DNS resolution with DuckDNS"
	echo	"    8) Edit the DNS configuration file with $edit"
	echo 	"    q) Finish work, I'm going to bed."
	until [ "$choice" = "q" ] || [ "$choice" = "h" ] || ([ "$choice" -ge 1 ] 2>/dev/null && [ "$choice" -le 8 ] 2>/dev/null)
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
		"3")
			echo "OOO" >&2
			;;  # todo
		"4")
			get_server
			if [ "$server" != "" ]
			then
				backups=$backups servers=$servers "$src/backup.sh" "$server"
			fi
			;;
		"5")
			echo "OOO" >&2
			;;  # todo
		"6")
			echo "Public IP address: $(curl -s ifconfig.me)"
			echo "Contents of $(basename $dns_conf):"
			cat "$dns_conf"
			echo
			;;
		"7")
			dns_conf="$dns_conf" "$src/duckdns.sh"
			;;
		"8")
			"$edit" "$dns_conf"
			;;
		"q")
			echo "Okay bye"
			break
			;;
	esac
	choice=""
done
