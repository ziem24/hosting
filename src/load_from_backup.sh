fn_load_from_backup() {
    local backup=0
    local num_backups=$(ls "$backups" | wc -l)
    local backup_=""
    local backup_idx=""

    fn_get_server
    echo "Choose a server backup:"
    fn_list_backups "$server"
    echo "    q) Cancel choice"

    until [ "$backup_idx" = "q" ] || ([ "$backup_idx" -ge 1 ] 2>/dev/null && [ "$backup_idx" -le "$num_backups" ] 2>/dev/null)
    do
        read -p "    > " backup_idx
        : "${backup_idx:=0}"
    done

    if [ "$backup_idx" = "q" ]
    then
        return 0
    fi

    backup=$(basename $(ls "$backups" | head -n "$backup_idx" | tail -1) ".zip")
    if [ -d "$servers/$backup" ]
    then
        read -p "The server name '$backup' already exists. Overwrite it? [y/N]: " choice
        if [ "x$choice" != "xy" ]
        then
            echo "Action cancelled."
            return 0
        fi
    fi

    mkdir -p "$ROOT/temp" && cd "$ROOT/temp"
    unzip "$backups/$backup" && mv * "$servers/$backup"
    cd "$ROOT"
    rm -rf "$ROOT/temp"

    echo "Loaded backup as $backup."
}