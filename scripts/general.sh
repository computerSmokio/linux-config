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

modules=("nvim" "tmux" "ghostty" "scripts" "hyprland" "eww" "rofi" "xplr")

cd "$DOTFILES" || exit 1
for module in "${modules[@]}"; do
    if [ -d "$module" ]; then
        safe_stow "$module"
    fi
done

# Set XDG Default Applications
if command -v xdg-mime &> /dev/null; then
    xdg-mime default brave-browser.desktop x-scheme-handler/http
    xdg-mime default brave-browser.desktop x-scheme-handler/https
    xdg-mime default brave-browser.desktop text/html
    xdg-mime default nvim.desktop text/plain
    xdg-mime default xplr.desktop inode/directory
fi

