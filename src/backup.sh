backup() {
	if [ $# = 0 ]
	then
		echo "Usage: $0 {server directory}" >& 2
		exit 1
	fi

	for i in $@
	do
		if [ -d "$servers/$1" ]
		then
			local zipname="$1"_`date +'%Y-%m-%d_%H-%M-%S'`.zip
			zip -r "$backups/$zipname" "$servers/$1/" && echo "Backup saved as '$zipname'"
		else
			echo "Server does not exist. Available servers:
$(ls $servers)" >&2
		fi
		shift
	done
}
