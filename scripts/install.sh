# Ask for the administrator password upfront
sudo -v 

ZSHRC_PATH="$HOME/.zshrc"

echo "" >> $ZSHRC_PATH
echo "# Custom shell aliases and functions"  >> $ZSHRC_PATH
echo "source $DOTFILES_PATH/shell/init.sh"  >> $ZSHRC_PATH

source $ZSHRC_PATH

echo "🔀 Setting Git config"
read -rp "✉️ What is you email? " git_email
read -rp "👤 And your name? " git_name
git config --global user.email "$git_email"
git config --global user.name "$git_name"

