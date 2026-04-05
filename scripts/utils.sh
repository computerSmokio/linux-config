#!/bin/bash

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

pkg_install() {
    case "$DISTRO" in
        arch)
            if ! command -v paru &> /dev/null; then
                _bootstrap_paru
            fi
            paru -S --needed --noconfirm "$@"
            ;;
        mac)
            if ! command -v brew &> /dev/null; then
                _bootstrap_brew
            fi
            brew install "$@"
            ;;
        *)
            return 1
            ;;
    esac
}

pkg_install_file() {
    local file="$1"
    if [ ! -f "$file" ]; then
        return 1
    fi
    
    local packages
    packages=$(grep -v '^#' "$file" | xargs)
    if [ -n "$packages" ]; then
        pkg_install $packages
    fi
}

_bootstrap_paru() {
    sudo pacman -S --needed --noconfirm base-devel git rustup
    local temp_dir
    temp_dir=$(mktemp -d)
    rustup default stable
    git clone https://aur.archlinux.org/paru-bin.git "$temp_dir"
    (cd "$temp_dir" && makepkg -si --noconfirm)
    rm -rf "$temp_dir"
}

_bootstrap_brew() {
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [ -f /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
}

install_antidote() {
    local antidote_dir="${HOME}/.antidote"
    if [ ! -d "$antidote_dir" ]; then
        git clone --depth=1 https://github.com/mattmc3/antidote.git "$antidote_dir"
    fi
}

set_zsh_default() {
    local zsh_path
    zsh_path=$(command -v zsh)
    if [ -n "$zsh_path" ] && [ "$SHELL" != "$zsh_path" ]; then
        sudo chsh -s "$zsh_path" "$USER"
    fi
}

safe_stow() {
    local module="$1"
    local target_dir="${2:-$HOME}"
    stow  -v -R -t "$target_dir" --adopt "$module"
}

setup_completion() {
    if ! command -v fzf &> /dev/null; then
        pkg_install fzf
    fi
    if [ "$DISTRO" == "mac" ]; then
        $(brew --prefix)/opt/fzf/install --all --no-bash --no-fish
    fi
}

confirm_action() {
    local msg="$1"
    read -p "$msg [y/N]: " -n 1 -r
    echo
    [[ $REPLY =~ ^[Yy]$ ]]
}
