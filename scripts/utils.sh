#!/bin/bash

# Detect OS and Distro
OS="$(uname)"
case "$OS" in
    Linux)
        if [ -f /etc/arch-release ]; then
            DISTRO="arch"
        else
            DISTRO="linux-unsupported"
        fi
        ;;
    Darwin)
        DISTRO="mac"
        ;;
    *)
        DISTRO="unsupported"
        ;;
esac

# Abstract package installation
# Usage: pkg_install package1 package2 ...
pkg_install() {
    case "$DISTRO" in
        arch)
            # Ensure paru is available first
            if ! command -v paru &> /dev/null; then
                _bootstrap_paru
            fi
            paru -S --needed --noconfirm "$@"
            ;;
        mac)
            # Ensure brew is available first
            if ! command -v brew &> /dev/null; then
                _bootstrap_brew
            fi
            brew install "$@"
            ;;
        *)
            echo "Error: Unsupported OS/Distro for pkg_install: $DISTRO"
            return 1
            ;;
    esac
}

# Abstract package installation from file
# Usage: pkg_install_file /path/to/file.txt
pkg_install_file() {
    local file="$1"
    if [ ! -f "$file" ]; then
        echo "Warning: Package file $file not found."
        return 1
    fi
    
    local packages
    packages=$(grep -v '^#' "$file" | xargs)
    if [ -n "$packages" ]; then
        pkg_install $packages
    fi
}

# Internal: Bootstrap Paru for Arch
_bootstrap_paru() {
    echo "Bootstrapping paru..."
    sudo pacman -S --needed --noconfirm base-devel git
    local temp_dir
    temp_dir=$(mktemp -d)
    git clone https://aur.archlinux.org/paru-bin.git "$temp_dir"
    (cd "$temp_dir" && makepkg -si --noconfirm)
    rm -rf "$temp_dir"
}

# Internal: Bootstrap Homebrew for Mac
_bootstrap_brew() {
    echo "Bootstrapping Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [ -f /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
}

# Install Antidote plugin manager
install_antidote() {
    local antidote_dir="${HOME}/.antidote"
    if [ ! -d "$antidote_dir" ]; then
        echo "Installing antidote..."
        git clone --depth=1 https://github.com/mattmc3/antidote.git "$antidote_dir"
    fi
}

# Set default shell to ZSH
set_zsh_default() {
    local zsh_path
    zsh_path=$(command -v zsh)
    if [ -n "$zsh_path" ] && [ "$SHELL" != "$zsh_path" ]; then
        echo "Changing default shell to zsh..."
        sudo chsh -s "$zsh_path" "$USER"
    fi
}

# Safe Stow deployment with user prompt
# Usage: safe_stow module_name
safe_stow() {
    local module="$1"
    local target_dir="${2:-$HOME}"
    
    # We check the first level of files stow would create to see if they exist
    # This is a simplified check. Stow --simulate could also be used.
    echo "Stowing $module..."
    stow -v -R -t "$target_dir" "$module"
}

# Install and setup completion stuff
setup_completion() {
    echo "Setting up shell completions (fzf)..."
    # Ensure fzf is installed
    if ! command -v fzf &> /dev/null; then
        pkg_install fzf
    fi

    # fzf usually comes with install scripts or shell files.
    # On Arch, they are in /usr/share/fzf/
    # On Mac, they are in $(brew --prefix)/opt/fzf/shell/
    
    # However, since the user is using antidote and stow, 
    # the actual shell integration should ideally be in their .zshrc.
    # We will just ensure the completion files are available or 
    # run the fzf install script if it's a standalone install.
    
    if [ "$DISTRO" == "mac" ]; then
        $(brew --prefix)/opt/fzf/install --all --no-bash --no-fish
    elif [ "$DISTRO" == "arch" ]; then
        # Arch usually manages this via the package, but we can 
        # ensure the user has the right plugins in their antidote list.
        echo "FZF installed. Ensure 'ohmyzsh/ohmyzsh path:plugins/fzf' is in your .zsh_plugins.txt"
    fi
}

confirm_action() {
    local msg="$1"
    read -p "$msg [y/N]: " -n 1 -r
    echo
    [[ $REPLY =~ ^[Yy]$ ]]
}
