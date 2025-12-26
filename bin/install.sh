export CONFIG_PATH="${XDG_CONFIG_HOME:-${HOME}/.config}"
export DOTFILES_PATH="$HOME/.local/share/dotfiles"

REPO="git@github.com:oBoolt/dotfiles"

if ! command -v git >/dev/null; then
    printf "ERROR: missing 'git'"
    exit 1
fi

printf "REPO: %s\n" $REPO
printf "INFO: Cloning repository...\n"
rm -rf $DOTFILES_PATH
git clone $REPO $DOTFILES_PATH >/dev/null
printf "INFO: Clone repository successfully\n"

$DOTFILES_PATH/bin/setup.sh config
