# PATH
[ -d "$HOME"/.local/bin ] && PATH=$PATH:$HOME/.local/bin
FPATH="$HOME/.docker/completions:$FPATH"

# Keybinds
bindkey -v
export KEYTIMEOUT=1

# History
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

autoload -Uz compinit; compinit

# On-demand rehash
zshcache_time="$(date +%s%N)"

autoload -Uz add-zsh-hook

rehash_precmd() {
  if [[ -e /var/cache/zsh/pacman ]]; then
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

# Cargo env
[ -x "$(command -v cargo)" ] && export PATH="$PATH:$HOME/.cargo/bin"

# Shell integrations
[ -x "$(command -v fzf)" ] && eval "$(fzf --zsh)"
[ -x "$(command -v starship)" ] && eval "$(starship init zsh)"
[ -x "$(command -v zoxide)" ] && eval "$(zoxide init zsh)"

# SSH
# set sock for ssh-agent
[[ $(systemctl --user status ssh-agent.service >/dev/null) -eq 0 ]] && export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# tmux
if [ -x "$(command -v tmux)" ] && [ -n "${DISPLAY}" ] && [ -z "${TMUX}" ]; then
    exec tmux new-session -A -s "${USER}" >/dev/null 2>&1
fi

source "${ZDOTDIR}/.zaliases"
