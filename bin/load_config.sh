#!/usr/bin/env bash
BACKUP_PATH="$DOTFILES_PATH/backup"


backup() {
    local pkg="$CONFIG_PATH/$1"
    if [ ! -h $pkg ] && [ -d $pkg ]; then
        printf "BACKUP: %s => %s\n" "$1" "$BACKUP_PATH/$1"
        mv $pkg $BACKUP_PATH/
    fi
}

stow_config() {
    if command -v stow >/dev/null; then
        stow -v -d $DOTFILES_PATH -t $CONFIG_PATH -S config
    fi
}

main() {
    if [ ! -e $DOTFILES_PATH/.installed ]; then
        mkdir -p $BACKUP_PATH
        for path in $DOTFILES_PATH/config/*; do
            local pkg="$(basename $path)"
            backup $pkg
        done
    fi

    if [ -d $BACKUP_PATH ] && [ -z "$(ls -A $BACKUP_PATH)" ]; then
        rm -r $BACKUP_PATH
    fi

    stow_config

    if [ $? -eq 0 ]; then
        touch $DOTFILES_PATH/.installed
        printf "INFO: all done, thank you!\n"
    fi
}

main
