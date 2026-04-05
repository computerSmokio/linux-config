#!/bin/bash

DOTFILES="${DOTFILES:-$HOME/.dotfiles}"

source "${DOTFILES}/scripts/utils.sh"

echo "Environment: OS=$OS, DISTRO=$DISTRO"

echo "Installing common packages..."
pkg_install_file "${DOTFILES}/packages/common_packages.txt"

if [ "$DISTRO" == "arch" ]; then
    echo "Installing Arch packages..."
    pkg_install_file "${DOTFILES}/packages/arch_packages.txt"
elif [ "$DISTRO" == "mac" ]; then
    echo "Installing Mac packages..."
    pkg_install_file "${DOTFILES}/packages/mac_packages.txt"
fi

echo "Setting up Antidote..."
install_antidote

echo "Setting up shell completions..."
setup_completion

echo "Setting ZSH as default shell..."
set_zsh_default

modules=("nvim" "tmux" "ghostty" "scripts")

cd "$DOTFILES" || exit 1
for module in "${modules[@]}"; do
    if [ -d "$module" ]; then
        # In a real environment, we'd add the "ask to overwrite" check logic here
        # But for now we use safe_stow which wraps the standard stow
        safe_stow "$module"
    else
        echo "Warning: Module $module not found in $DOTFILES"
    fi
done

echo "General setup complete."
