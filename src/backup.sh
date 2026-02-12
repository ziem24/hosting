#!/bin/sh

if [ $# = 0 ]
then
	echo "Usage: $0 {server directory}" >& 2
	exit 1
fi

oldpwd=$(pwd)
cd $servers

for i in $@
do
	if [ -d "$1" ]
	then
		zipname="$1"_`date +'%Y-%m-%d_%H-%M-%S'`.zip
		zip -r "$backups/$zipname" "$1/" && echo "Backup saved at '$zipname'"
	else
		echo "Server does not exist. Available servers:
$(ls $servers)" >&2
	fi
	shift
done

cd "$oldpwd"
