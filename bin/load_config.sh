#!/usr/bin/env bash
BACKUP_PATH="$DOTFILES_PATH/backup"

backup() {
    local pkg="$CONFIG_PATH/$1"
    if [ ! -h $pkg ] && [ -d $pkg ]; then
        printf "BACKUP: %s => %s\n" "$1" "$BACKUP_PATH/$1"
        mv $pkg $BACKUP_PATH/
    fi
}

mkdir -p $BACKUP_PATH
for path in $DOTFILES_PATH/config/*; do
    pkg_name="$(basename $path)"
    backup $pkg_name
done

if [ -d $BACKUP_PATH ] && [ -z "$(ls -A $BACKUP_PATH)" ]; then
    rm -r $BACKUP_PATH
fi

if command -v stow >/dev/null; then
    stow -v -d $DOTFILES_PATH -t $CONFIG_PATH -R config
fi

if [ $? -eq 0 ]; then
    printf "INFO: all done, thank you!\n"
fi
