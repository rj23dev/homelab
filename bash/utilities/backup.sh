#!/usr/bin/env bash

src_dir="$HOME/source"
dest_dir="$HOME/backup"
backup_dir="${dest_dir}/$(date +%Y-%m-%d_%H-%M-%S)"
log_file="$HOME/my_backup.log"
max_backup=5

log() {
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" >> "$log_file"
}

log "===== Backup run started ====="

if [[ ! -d "$src_dir" ]]; then

        log "Source directory not present!"

        exit 1

fi

if [[ ! -d "$dest_dir" ]]; then

        mkdir -p "$dest_dir"

fi

if rsync -ah "$src_dir/" "$backup_dir/" &>/dev/null; then

        log "Backup created: $backup_dir"

else

        log "ERROR: Backup failed!"

        exit 1

fi

shopt -s nullglob

backups=( "$dest_dir"/????-??-??_??-??-??/ )

mapfile -t backups < <(printf '%s\n' "${backups[@]}" | sort)

shopt -u nullglob

total_backups=${#backups[@]}

if (( total_backups > max_backup )); then

        backups_to_remove=$(( total_backups - max_backup ))

        for (( i=0; i<backups_to_remove; i++ ));do

                dir="${backups[i]}"

                if [[ -n "$dir" && -d "$dir" && "$dir" == "$dest_dir"/* ]]; then

                        rm -rf "$dir"

                        log "Deleting old backup: $dir"

                fi

        done

fi

log "===== Backup run finished ====="
