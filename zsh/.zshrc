# Install zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Plugins
#zinit light zsh-users/zsh-syntax-highlighting
#zinit light zsh-users/zsh-completions
#zinit light Aloxaf/fzf-tab

[ -e $HOME/.aliases ] && source ~/.aliases
[ -d $HOME/.local/bin ] && PATH=$PATH:$HOME/.local/bin

# Keybinds
#bindkey -v

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

# Completion
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
#zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
#zstyle ':completion:*' menu no
#zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# NVM
source /usr/share/nvm/init-nvm.sh
# Environment variables
#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if [ -x $(which nvim) ]; then
    export EDITOR="$(which nvim)"
    export VISUAL="$(which nvim)"
fi
# Cargo env
[ -x $(which cargo) ] && export PATH="$PATH:$HOME/.cargo/bin"
# Bat to man
[ -x $(which bat) ] && export MANPAGER="sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"

# Shell integrations
[ -x $(which fzf) ] && eval "$(fzf --zsh)"
[ -x $(which starship) ] && eval "$(starship init zsh)"
# Android SDK
# Set ANDROID_HOME 
[ -d $ANDROID_HOME ] && PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin

# SSH
# set sock for ssh-agent
[[ $(systemctl --user status ssh-agent.service >/dev/null) -eq 0 ]] && export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
