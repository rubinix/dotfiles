#!/usr/bin/env bash
# Bootstrap a new macOS workstation: Homebrew, iTerm2, JetBrains Mono Nerd
# Font, dotfiles, oh-my-zsh.

cd "$HOME"

# Install Homebrew if missing.
if ! command -v brew >/dev/null 2>&1; then
  echo "Installing Homebrew..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Make brew available in this shell regardless of arch.
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# iTerm2 + the Nerd Font my iTerm profile references. Skip iTerm2 if it's
# already present (e.g. installed manually) — brew refuses to overwrite.
[ -d /Applications/iTerm.app ] || brew install --cask iterm2
brew install --cask font-jetbrains-mono-nerd-font

# Clone the dotfiles bare repo and check out into $HOME, backing up any
# pre-existing conflicting files into ~/.dotfiles-backup/ (parent dirs preserved).
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

# Point iTerm2 at the dotfiles-managed prefs folder.
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$HOME/.config/iterm2"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true

# Install oh-my-zsh (KEEP_ZSHRC preserves the .zshrc we just checked out).
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing oh-my-zsh..."
  RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo "Done. Open a new shell so the 'dotfiles' function (defined in ~/.zshrc) is loaded."
