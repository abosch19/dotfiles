#!/usr/bin/env zsh

set -euo pipefail

# Cache admin credentials upfront ONLY if sudo is usable.
# Some accounts have a locked/disabled password and can't use sudo;
# nothing here strictly requires root, so we don't abort if it fails.
if command -v sudo &> /dev/null && sudo -v 2>/dev/null; then
  echo "🔑 Admin credentials cached."
else
  echo "ℹ️  Skipping sudo (no admin password available) — not required for install."
fi

ZSHRC_PATH="$HOME/.zshrc"
SOURCE_LINE="source $DOTFILES_PATH/shell/init.sh"

# Only add the source line if it isn't already there (idempotent)
if ! grep -qF "$SOURCE_LINE" "$ZSHRC_PATH" 2>/dev/null; then
  echo "" >> "$ZSHRC_PATH"
  echo "# Custom shell aliases and functions" >> "$ZSHRC_PATH"
  echo "$SOURCE_LINE" >> "$ZSHRC_PATH"
  echo "✅ Added dotfiles to $ZSHRC_PATH"
else
  echo "ℹ️  dotfiles already sourced in $ZSHRC_PATH — skipping."
fi

echo "🔀 Setting Git config"
read -rp "✉️  What is your email? " git_email
read -rp "👤 And your name? " git_name
git config --global user.email "$git_email"
git config --global user.name "$git_name"

echo "🎉 Done! Restart your terminal or run: source $ZSHRC_PATH"
