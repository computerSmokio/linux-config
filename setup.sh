#!/bin/bash

export DOTFILES="${DOTFILES:-$HOME/.dotfiles}"
DF_BRANCH="${DF_BRANCH:-main}"
REPO_URL="https://github.com/computersmokio/linux-config.git"

command -v git &> /dev/null || exit 1
command -v curl &> /dev/null || exit 1

if [ ! -d "$DOTFILES" ]; then
    git clone -b "$DF_BRANCH" "$REPO_URL" "$DOTFILES"
else
    (cd "$DOTFILES" && git checkout "$DF_BRANCH" && git pull origin "$DF_BRANCH") || exit 1
fi

chmod +x "$DOTFILES/scripts/utils.sh"
chmod +x "$DOTFILES/scripts/general.sh"

source "$DOTFILES/scripts/utils.sh"
"$DOTFILES/scripts/general.sh"
