fn_list_servers() {
	local i=0
	for s in "$servers"/*
	do
		local i=$(expr "$i" + 1)
		echo "    $i) $(basename $s)"
	done
}
