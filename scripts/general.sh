#!/bin/bash

DOTFILES="${DOTFILES:-$HOME/.dotfiles}"
source "${DOTFILES}/scripts/utils.sh"

pkg_install_file "${DOTFILES}/packages/common_packages.txt"

if [ "$DISTRO" == "arch" ]; then
    pkg_install_file "${DOTFILES}/packages/arch_packages.txt"
elif [ "$DISTRO" == "mac" ]; then
    pkg_install_file "${DOTFILES}/packages/mac_packages.txt"
fi

install_antidote
setup_completion
set_zsh_default

modules=("nvim" "tmux" "ghostty" "scripts" "hyprland" "eww" "rofi")

cd "$DOTFILES" || exit 1
for module in "${modules[@]}"; do
    if [ -d "$module" ]; then
        safe_stow "$module"
    fi
done
