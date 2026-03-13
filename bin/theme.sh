#!/usr/bin/env bash
THEME_PATH="${DOTFILES_PATH}/themes"
declare -a THEMES

for theme in ${DOTFILES_PATH}/themes/*; do
    if [[ -d "${theme}" && ! -h "${theme}" ]]; then
        THEMES+=("${theme##*/}")
    fi
done

if [[ "${1,,}" == "--list" ]]; then
    success "${THEMES[*]}"
    exit 0
fi

if [[ -n "$1" ]]; then
    VALID=false
    for theme in ${THEMES[@]}; do
        if [[ "${theme}" = "${1,,}" ]]; then
            VALID=true
        fi
    done

    if ! ${VALID}; then
        error "invalid theme '$1'"
        exit 1
    fi

    ln -sfn "${THEME_PATH}"/"${1,,}" "${THEME_PATH}"/current
    success "current theme set to '${1,,}'"
    exit 0
fi

if [[ -z "$1" ]]; then
    CURRENT_THEME="$(realpath "${THEME_PATH}"/current)"
    if [[ "${CURRENT_THEME##*/}" = "current" ]]; then
        warn "no theme set"
        exit 0
    fi
    info "the current theme is '${CURRENT_THEME}'"
fi
