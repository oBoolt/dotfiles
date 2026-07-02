export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"

export DOTFILES_PATH="${HOME}/.local/share/dotfiles"
export STARSHIP_CONFIG="$XDG_CONFIG_HOME"/starship/starship.toml
export GIT_CONFIG_GLOBAL="$XDG_CONFIG_HOME"/git/.gitconfig

export HISTSIZE=5000
export HISTFILE=~/.zsh_history
export SAVEHIST=$HISTSIZE
export HISTDUP=erase
export KEYTIMEOUT=5

if [ -x "$(command -v nvim)" ]; then
    local nvim="$(command -v nvim)"
    export EDITOR="$nvim"
    export VISUAL="$nvim"
    export MANPAGER="$nvim +Man!"
fi

export QT_QPA_PLATFORMTHEME=qt5ct
