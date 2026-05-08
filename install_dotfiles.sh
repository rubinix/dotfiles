#!/usr/bin/env bash
# Install dotfiles from the bare repo at ~/.dotfiles.
# Pre-existing conflicting files are moved to ~/.dotfiles-backup/, preserving
# their relative paths (so nested paths like .config/nvim/init.lua survive).

cd "$HOME"

git clone --bare https://github.com/rubinix/dotfiles.git "$HOME/.dotfiles"

dotfiles() {
  /usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" "$@"
}

mkdir -p "$HOME/.dotfiles-backup"

if dotfiles checkout 2>/dev/null; then
  echo "Checked out dotfiles."
else
  echo "Backing up pre-existing dotfiles to ~/.dotfiles-backup ..."
  dotfiles checkout 2>&1 | grep -E '^\s+\S' | awk '{print $1}' | while read -r f; do
    mkdir -p "$HOME/.dotfiles-backup/$(dirname "$f")"
    mv "$HOME/$f" "$HOME/.dotfiles-backup/$f"
  done
  dotfiles checkout
fi

dotfiles config status.showUntrackedFiles no

echo "Done. Open a new shell so the 'dotfiles' function (defined in ~/.zshrc) is loaded."
