if [ "$(tty)" = "/dev/tty1" ]; then
    export DOTFILES_PATH="${HOME}/.local/share/dotfiles"
    if uwsm check may-start; then
        exec uwsm start hyprland.desktop
    fi
fi
