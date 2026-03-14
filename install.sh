#!/usr/bin/env bash
DOTFILES_PATH="${HOME}/.local/share/dotfiles"
DOTFILES_REPOSITORY="https://github.com/oBoolt/dotfiles.git"

error() {
    local tmp=${2:-error}
    printf "%b\n" "\e[1m\e[38;5;1m${tmp,,}:\e[0m $1"
}

success() {
    local tmp=${2:-success}
    printf "%b\n" "\e[1m\e[38;5;2m${tmp,,}:\e[0m $1"
}

warn() {
    tmp=${2:-warn}
    printf "%b" "\e[1m\e[38;5;3m${tmp,,}:\e[0m $1"
}

info() {
    local tmp=${2:-info}
    printf "%b\n" "\e[1m\e[38;5;6m${tmp,,}:\e[0m $1"
}

question() {
    while true; do
        read q
        case $q in
            [Nn]*) return 1  ;;  
            *) return 0 ;;
        esac
    done
}

install_repository() {
    if [[ -d "${DOTFILES_PATH}" ]]; then
        warn "dotfiles already exists\n"
        warn "would you like to replace them with my? [Y/n]: "
        question
        
        if [[ $? = 1 ]]; then
            exit 0
        fi

        rm -rf "${DOTFILES_PATH}"
        info "old dotfiles removed" 
    fi

    git clone "${DOTFILES_REPOSITORY}" "${DOTFILES_PATH}"
    if [[ $? != 0 ]]; then
        error "git couldn't clone the repository (${DOTFILES_REPOSITORY})"
        error "exiting"
        exit 1
    fi

    success "dotfiles located in '${DOTFILES_PATH}'" 
}

install_dependencies() {
    info "installing dependencies"
    mapfile -t DEPENDENCIES < "${DOTFILES_PATH}/dependencies.packages"
    sudo pacman -S --noconfirm --needed "${DEPENDENCIES[@]}"
    success "all modules dependencies installed" 
}

install_aura() {
    info "installing aura"
    git clone "https://aur.archlinux.org/aura.git" "/tmp/aura"
    cd "/tmp/aura"
    makepkg --noconfirm -csi
    cd - >/dev/null
}

add_path() {
    mkdir -p "${HOME}/.local/bin" >/dev/null
    ln -sfn "${DOTFILES_PATH}/bin/dotfiles" "${HOME}/.local/bin/dotfiles"
    if [[ ! -x "$(command -v dotfiles)" ]]; then
        PATH=$PATH:"${HOME}/.local/bin"
    fi
    
    info "added 'dotfiles' command"
}

if [[ ! "$(grep '^ID=\we*' /etc/os-release | cut -d = -f 2)" = "arch" ]]; then
    error "only for arch"
    exit 1
fi

if [[ "$(id -u)" = 0 ]]; then
    error "you are not supposed to run this as root"
    exit 1
fi

if [[ ! -x "$(command -v git)" ]]; then
    warn "git not found"
    info "installing"
    sudo pacman -S --noconfirm git
fi

install_repository
install_dependencies

if [[ ! -x "$(command -v aura)" ]]; then
    warn "would you like to install aura (pacman wrapper and aur helper)? [Y/n]: "
    question
    if [[ $? = 0 ]]; then
        install_aura
    fi
fi

add_path

CONFIG_ACCEPTED=0
warn "would you like to replace the config (a backup will be made)? [Y/n]: "
question
if [[ $? = 0 ]]; then 
    dotfiles config
    CONFIG_ACCEPTED=1
fi

success "thank you!"
if [[ "${CONFIG_ACCEPTED}" = 0 ]]; then
    success "use 'dotfiles config' to setup the dotfiles"
fi
