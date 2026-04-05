#!/bin/bash

# Main Setup Script for Dotfiles
# Usage: curl -fsSL <raw_url> | bash

# Ensure DOTFILES path is set
export DOTFILES="${DOTFILES:-$HOME/.dotfiles}"
REPO_URL="https://github.com/computersmokio/linux-config.git"

# 1. Dependency check (minimum needed for bootstrap)
command -v git &> /dev/null || { echo "Git is required."; exit 1; }
command -v curl &> /dev/null || { echo "Curl is required."; exit 1; }

# 2. Clone repo if not exists
if [ ! -d "$DOTFILES" ]; then
    echo "Cloning dotfiles to $DOTFILES..."
    git clone "$REPO_URL" "$DOTFILES"
else
    echo "Updating dotfiles in $DOTFILES..."
    (cd "$DOTFILES" && git pull) || exit 1
fi

# 3. Make scripts executable
chmod +x "$DOTFILES/scripts/utils.sh"
chmod +x "$DOTFILES/scripts/general.sh"

# 4. Run modular scripts
# We source utils to have the functions available here too if needed,
# though we mostly rely on calling general.sh.
source "$DOTFILES/scripts/utils.sh"

echo "Starting General setup..."
"$DOTFILES/scripts/general.sh"

echo "Setup finished successfully."
