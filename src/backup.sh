fn_backup() {
	if [ $# = 0 ]
	then
		echo "Usage: $0 <server directory>" >&2
		return 1
	fi

	for i in $@
	do
		if [ -d "$servers/$1" ]
		then
			local zipname="$(date +'%Y-%m-%d_%H-%M-%S').zip"
			mkdir -p "$backups/$1/"
			zip -r "$backups/$1/$zipname" "$servers/$1/" && echo "Backup saved as '$zipname'"
		else
			echo "Server does not exist. Available servers:" >&2
			echo $(ls $servers) >&2
		fi
		shift
	done
}
