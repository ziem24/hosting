fn_start() {
	if [ $# != 1 ]
	then
		echo "Usage: $0 <server directory>" >&2
		return 1
	fi

	if [ ! -d "$servers/$1" ]
	then
		echo "Error: Could not find a server '$1'. Available servers:" >&2
		echo $(ls $servers) >&2
		return 2
	fi

	local oldpwd=$(pwd)
	cd "$servers/$1"
	echo "Starting server '$1'
	Stop the server using 'stop'
	==================================================="

	./run.sh || ./start.sh  # forge + fabric compatibility
	local exitc=$?

	cd "$oldpwd"

	if [ $exitc = 0 ]
	then
		read -p "Server has stopped running. Make a backup? [y/N]: " answer
		if [ "$answer" = "y" ]
		then
			fn_backup "$1"
		fi
	fi

	echo "Finished"
}
