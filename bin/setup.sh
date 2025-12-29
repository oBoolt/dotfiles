#!/usr/bin/env bash
export CONFIG_PATH="${XDG_CONFIG_HOME:-${HOME}/.config}"
export DOTFILES_PATH="${DOTFILES_PATH:-$HOME/.local/share/dotfiles}"

error() {
    printf "%b\n" "\e[1m\e[38;5;1mERROR:\e[0m $@"
}
success() {
    printf "%b\n" "\e[1m\e[38;5;2mSUCS:\e[0m $@"
}
warn() {
    printf "%b\n" "\e[1m\e[38;5;3mWARN:\e[0m $@"
}
info() {
    printf "%b\n" "\e[1m\e[38;5;6mINFO:\e[0m $@"
}
debug() {
    printf "%b\n" "\e[1m\e[38;5;5mDEBUG:\e[0m $@"
}

export -f error
export -f success
export -f warn
export -f info
export -f debug

if [ "$(id -u)" = 0 ]; then
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
            warn "usage setup.sh <config>"
        fi
        ;;
esac

