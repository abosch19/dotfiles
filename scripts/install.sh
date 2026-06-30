#!/usr/bin/env bash

set -euo pipefail

DOTFILES_PATH="${DOTFILES_PATH:-$HOME/.dotfiles}"

# Cache admin credentials upfront ONLY if sudo is usable.
# Some accounts have a locked/disabled password and can't use sudo;
# nothing here strictly requires root, so we don't abort if it fails.
if command -v sudo &> /dev/null && sudo -v 2>/dev/null; then
  echo "🔑 Admin credentials cached."
else
  echo "ℹ️  Skipping sudo (no admin password available) — not required for install."
fi

# Decide which rc file to write to, based on the user's login shell.
case "${SHELL:-}" in
  *zsh)  RC_PATH="$HOME/.zshrc" ;;
  *bash) RC_PATH="$HOME/.bashrc" ;;
  *)
    # Fall back to whatever is installed (prefer zsh).
    if command -v zsh &> /dev/null; then
      RC_PATH="$HOME/.zshrc"
    else
      RC_PATH="$HOME/.bashrc"
    fi
    ;;
esac

SOURCE_LINE="source $DOTFILES_PATH/shell/init.sh"

# Only add the source line if it isn't already there (idempotent)
if ! grep -qF "$SOURCE_LINE" "$RC_PATH" 2>/dev/null; then
  echo "" >> "$RC_PATH"
  echo "# Custom shell aliases and functions" >> "$RC_PATH"
  echo "$SOURCE_LINE" >> "$RC_PATH"
  echo "✅ Added dotfiles to $RC_PATH"
else
  echo "ℹ️  dotfiles already sourced in $RC_PATH — skipping."
fi

echo "🔀 Setting Git config"
printf "✉️  What is your email? "
read -r git_email
printf "👤 And your name? "
read -r git_name
git config --global user.email "$git_email"
git config --global user.name "$git_name"

# Load the new config into the current session (don't abort if something errors)
# shellcheck disable=SC1090
source "$RC_PATH" || echo "⚠️  Could not source $RC_PATH automatically — restart your terminal."

echo "🎉 Done!"
