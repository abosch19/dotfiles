DOTFILES_PATH="$HOME/.dotfiles"

#Register all aliases
for aliasToSource in "$DOTFILES_PATH/shell/_aliases/"*; do source "$aliasToSource"; done

#Register all functions
for functionsToSource in "$DOTFILES_PATH/shell/_functions/"*; do source "$functionsToSource"; done
