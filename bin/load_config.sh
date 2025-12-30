#!/usr/bin/env bash
BACKUP_PATH="$DOTFILES_PATH/backup"
declare -a PKGS

backup() {
    local pkg="$CONFIG_PATH/$1"
    if [ ! -h $pkg ] && [ -d $pkg ]; then
        info "BACKUP"
        success "$1 => $BACKUP_PATH/$1"
        mv $pkg $BACKUP_PATH/
    fi
}

mkdir -p $BACKUP_PATH
for path in $DOTFILES_PATH/config/*; do
    pkg_name="$(basename $path)"
    PKGS+=($pkg_name)
    backup $pkg_name
done

if [ -d $BACKUP_PATH ] && [ -z "$(ls -A $BACKUP_PATH)" ]; then
    rm -r $BACKUP_PATH
fi

if command -v stow >/dev/null; then
    stow -d $DOTFILES_PATH -t $CONFIG_PATH -R config
    for pkg in ${PKGS[@]}; do
        info "$pkg => $DOTFILES_PATH/config/$pkg" "link"
    done
fi

if [ $? -eq 0 ]; then
    success "all done, thank you!"
fi
