#!/usr/bin/env bash
export CONFIG_PATH="${XDG_CONFIG_HOME:-${HOME}/.config}"
export DOTFILES_PATH="${DOTFILES_PATH:-$HOME/.local/share/dotfiles}"

case "$1" in
    config)
        $DOTFILES_PATH/bin/load_config.sh
        ;;
    *)
        if [ "$DOTFILES_INSTALL" = true ]; then
            DOTFILES_REPOSITORY="${DOTFILES_REPOSITORY:-git@github.com:oBoolt/dotfiles}"

            if ! command -v git >/dev/null; then
                printf "ERROR: missing 'git'"
                exit 1
            fi

            printf "REPO: %s\n" $DOTFILES_REPOSITORY
            printf "INFO: Cloning repository...\n"
            rm -rf $DOTFILES_PATH
            git clone $DOTFILES_REPOSITORY $DOTFILES_PATH >/dev/null
            printf "INFO: Clone repository successfully\n"

            $DOTFILES_PATH/bin/load_config.sh
        else
            printf "Usage: setup.sh <config>\n" $0
        fi
        ;;
esac

