#!/usr/bin/env bash
export CONFIG_PATH="${XDG_CONFIG_HOME:-${HOME}/.config}"
export DOTFILES_PATH="${DOTFILES_PATH:-$HOME/.local/share/dotfiles}"

error() {
    tmp=${2:-error}
    printf "%b\n" "\e[1m\e[38;5;1m${tmp^^}:\e[0m $1"
}
success() {
    tmp=${2:-sucs}
    printf "%b\n" "\e[1m\e[38;5;2m${tmp^^}:\e[0m $1"
}
warn() {
    tmp=${2:-warn}
    printf "%b\n" "\e[1m\e[38;5;3m${tmp^^}:\e[0m $1"
}
debug() {
    tmp=${2:-debug}
    printf "%b\n" "\e[1m\e[38;5;5m${tmp^^}:\e[0m $1"
}
info() {
    tmp=${2:-info}
    printf "%b\n" "\e[1m\e[38;5;6m${tmp^^}:\e[0m $1"
}

export -f error
export -f success
export -f warn
export -f info
export -f debug

if [ "$(id -u)" = 0 ]; then
    error "you are not supposed to run this as root"
    exit 1
fi

case "$1" in
    config)
        $DOTFILES_PATH/bin/load_config.sh
        ;;
    *)
        if [ "$DOTFILES_INSTALL" = true ]; then
            DOTFILES_REPOSITORY="${DOTFILES_REPOSITORY:-git@github.com:oBoolt/dotfiles}"

            if ! command -v git >/dev/null; then
                error "missing 'git'"
                exit 1
            fi

            info "repository ($DOTFILES_REPOSITORY)"
            info "cloning repository..."
            rm -rf $DOTFILES_PATH
            git clone $DOTFILES_REPOSITORY $DOTFILES_PATH >/dev/null
            info "cloned repository successfully"

            $DOTFILES_PATH/bin/load_config.sh
        else
            warn "setup.sh <config>" "usage"
        fi
        ;;
esac

