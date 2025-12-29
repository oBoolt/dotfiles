# Variables
CONFIG_PATH="${XDG_CONFIG_HOME:-${HOME}/.config}"
DOTFILES_PATH="${DOTFILES_PATH:-${HOME}/.local/share/dotfiles}"
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
export STARSHIP_CONFIG=$CONFIG_PATH/starship/starship.toml
export GIT_CONFIG_GLOBAL=$CONFIG_PATH/git/.gitconfig


# Install zinit
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Plugins
#zinit light zsh-users/zsh-syntax-highlighting
#zinit light zsh-users/zsh-completions
#zinit light Aloxaf/fzf-tab

[ -e $CONFIG_PATH/zsh/.aliases ] && source $CONFIG_PATH/zsh/.aliases
[ -d $HOME/.local/bin ] && PATH=$PATH:$HOME/.local/bin

# Keybinds
bindkey -v
export KEYTIMEOUT=5

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# On-demand rehash
zshcache_time="$(date +%s%N)"

autoload -Uz add-zsh-hook

rehash_precmd() {
  if [[ -a /var/cache/zsh/pacman ]]; then
    local paccache_time="$(date -r /var/cache/zsh/pacman +%s%N)"
    if (( zshcache_time < paccache_time )); then
      rehash
      zshcache_time="$paccache_time"
    fi
  fi
}

add-zsh-hook -Uz precmd rehash_precmd

# Completion
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
#zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
#zstyle ':completion:*' menu no
#zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# NVM
source /usr/share/nvm/init-nvm.sh
# Environment variables
#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if [ -x "$(command -v nvim)" ]; then
    export EDITOR="$(which nvim)"
    export VISUAL="$(which nvim)"
    export MANPAGER="$(which nvim) +Man!"
fi
# Cargo env
[ -x "$(command -v cargo)" ] && export PATH="$PATH:$HOME/.cargo/bin"

# Shell integrations
[ -x "$(command -v fzf)" ] && eval "$(fzf --zsh)"
[ -x "$(command -v starship)" ] && eval "$(starship init zsh)"

# SSH
# set sock for ssh-agent
[[ $(systemctl --user status ssh-agent.service >/dev/null) -eq 0 ]] && export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# tmux
if [ -x "$(command -v tmux)" ] && [ -n "${DISPLAY}" ] && [ -z "${TMUX}" ]; then
    exec tmux new-session -A -s ${USER} >/dev/null 2>&1
fi

# docker
FPATH="$HOME/.docker/completions:$FPATH"
autoload -Uz compinit
compinit
