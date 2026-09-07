fn_list_backups() {  # 1 - server name
    local i=0
    if [ ! -e "$backups/$1" ] || [ $(ls "$backups/$1" | wc -l) = 0 ]
    then
        return 1
    fi

    for s in "$backups/$1"/*
    do
        local i=$(expr "$i" + 1)
        echo "    $i) $(basename $s)"
    done
}
