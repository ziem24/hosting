fn_load_from_backup() {
    local num_backups=$(ls "$backups" | wc -l)
    local backup_idx=""

    fn_get_server
    if [ "$server" = "" ]
    then
        return 0
    fi

    echo "Choose a server backup:"
    if ! fn_list_dir "$backups/$server"
    then
        echo "No backups available for this server." >&2
        return 1
    fi
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

    local backup=$(basename $(ls "$backups/$server" | head -n "$backup_idx" | tail -1) ".zip")
    local backup_name="$server"_"$backup" # Doing "$server_$backup" won't work because why would it

    if [ -d "$servers/$backup_name" ]
    then
        read -p "The server name '$backup_name' already exists. Overwrite it? [y/N]: " choice
        if [ "x$choice" != "xy" ]
        then
            echo "Action cancelled."
            return 0
        fi
    fi

    mkdir -p "$ROOT/temp"
    unzip "$backups/$server/$backup" -d "$ROOT/temp"
    mv -f "$ROOT"/temp/* "$servers/$backup_name"
    rmdir "$ROOT/temp"

    echo "Loaded backup as $backup_name."
}
