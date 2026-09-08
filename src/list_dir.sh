fn_list_dir() {  # 1 - directory to list
    local i=0
    if [ ! -e "$1" ] || [ $(ls "$1" | wc -l) = 0 ]
    then
        return 1
    fi

    for s in "$1"/*
    do
        local i=$(expr "$i" + 1)
        echo "    $i) $(basename $s)"
    done
}
