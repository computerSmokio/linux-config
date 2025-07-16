# Dotfiles

This repository contains configuration files (dotfiles) for various tools and applications. It is designed to help you quickly set up your development environment by managing your dotfiles in a centralized location.

## Usage with GNU Stow

1. **Clone the repository:**

    git clone https://github.com/yourusername/dotfiles.git
    cd dotfiles

2. **Install GNU Stow:**

    sudo apt-get install stow  # On Debian/Ubuntu
    # or
    brew install stow          # On macOS

3. **Stow a package:**

    stow <package>

   Replace `<package>` with the name of the folder containing the dotfiles you want to symlink (e.g., `zsh`, `nvim`, `git`). This will create symlinks in your home directory.

   Example:

    stow zsh

4. **Unstow a package:**

    stow -D <package>

## Folder Structure

Each folder in this repo represents a set of configuration files for a specific application. For example:

- `zsh/` contains `.zshrc`
- `nvim/` contains `.config/nvim/`
- `git/` contains `.gitconfig`

## Notes

- Make sure to run stow from the root of the repository.
- Existing files in your home directory may need to be removed or backed up before stowing.

