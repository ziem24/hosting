start() {
	if [ $# != 1 ]
	then
		echo "Usage: $0 {server directory}" >& 2
		exit 1
	fi

	if [ ! -d "$servers/$1" ]
	then
		echo "Error: Could not find a server '$1'. Available servers:
	$(ls $servers)" >& 2
		exit 2
	fi

	local oldpwd=$(pwd)
	cd "$servers/$1"


	echo "Starting server '$1'
	Stop the server using 'stop'
	==================================================="

	./run.sh || ./start.sh # forge + fabric compatibility
	local exitc=$?

	cd "$oldpwd"

	if [ $exitc = 0 ]
	then
		read -p "Server has stopped running. Make a backup? [y/N]: " answer

		if [ "$answer" = "y" ]
		then
			"$(dirname $(realpath $0))/backup.sh" "$1"
		fi
	fi

	echo "Finished"
}
