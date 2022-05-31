# Ask for the administrator password upfront
sudo -v 

echo "# Custom shell aliases and functions"  >> "$HOME_PATH/.zshrc"
echo "source $DOTFILES_PATH/shell/init.sh"  >> "$HOME_PATH/.zshrc"

echo "🔀 Setting Git config"
read -rp "✉️ What is you email? " git_email
read -rp "👤 And your name? " git_name
git config --global user.email "$git_email"
git config --global user.name "$git_name"