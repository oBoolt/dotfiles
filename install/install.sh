#!/usr/bin/env bash
CONFIG_PATH="${XDG_CONFIG_HOME:-${HOME}/.config}"
DOTFILES_PATH="$HOME/.local/share/dotfiles"
BACKUP_PATH="$DOTFILES_PATH/backup"

REPO="https://github.com/oBoolt/dotfiles"

download_repo() {
    if ! command -v git >/dev/null; then
        printf "ERROR: missing 'git'"
        exit 1
    fi

    printf "REPO: %s\n" $REPO
    printf "INFO: Cloning repository...\n"
    rm -rf $DOTFILES_PATH
    git clone $REPO $DOTFILES_PATH >/dev/null
    printf "INFO: Clone repository successfully\n"
}

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
        download_repo
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
