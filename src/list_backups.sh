fn_list_backups() {  # 1 - server name
	local i=0
	for s in $(ls $backups | grep "$1") # todo: edge cases
	do
		local i=$(expr "$i" + 1)
		echo "    $i) $(basename $s)"
	done
}
