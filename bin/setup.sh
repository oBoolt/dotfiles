#!/usr/bin/env bash
export CONFIG_PATH="${CONFIG_PATH:-${XDG_CONFIG_HOME:-${HOME}/.config}}"
export DOTFILES_PATH="${DOTFILES_PATH:-$HOME/.local/share/dotfiles}"

case "$1" in
    config)
        $DOTFILES_PATH/bin/load_config.sh
        ;;
    *)
        printf "Usage: %s <config>" $0
        ;;
esac
 
