#!/bin/bash
set -e

# Run all dotfiles installers.
# export PATH="$HOME/.dotfiles:$PATH"
export DOTFILES_ROOT="$HOME/.dotfiles"
CONFIG_DIR="$DOTFILES_ROOT/config"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

echo ''

info () {
  printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

# Define a function which rename a `target` file to `target.backup` if the file
# exists and if it's a 'real' file, ie not a symlink
backup() {
  target=$1
  if [ -e "$target" ]; then
    if [ ! -L "$target" ]; then
      mv "$target" "$target.backup"
      info "-----> Moved your old $target config file to $target.backup"
    fi
  fi
}

symlink() {
  file=$1
  link=$2
  if [ ! -e "$link" ]; then
    info "-----> Symlinking your new $link"
    ln -sf $file $link
  fi
}

# Install Homebrew packages
install_packages() {
    info "-----> Installing Homebrew packages"
    brew bundle --no-upgrade --file="$DOTFILES_ROOT/Brewfile"
}

install_dotfiles () {
  local overwrite_all=false backup_all=false skip_all=false

  for file in $(find -H "$DOTFILES_ROOT/config" -maxdepth 2 -name '*.symlink' -not -path '*.git*'); do
    local source="$file"
    local filename=$(basename "$file")
    local target="$HOME/.${filename%.*}"

    if [ -f "$target" ]; then
      backup "$target"
    fi

    symlink "$source" "$target"
  done
}

install_zsh_plugins() {
  CURRENT_DIR=`pwd`
  ZSH_PLUGINS_DIR=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
  mkdir -p "$ZSH_PLUGINS_DIR" && cd "$ZSH_PLUGINS_DIR"
  if [ ! -d "$ZSH_PLUGINS_DIR/zsh-syntax-highlighting" ]; then
    info "-----> Installing zsh plugins"
    git clone https://github.com/zsh-users/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting
  fi
  cd "$CURRENT_DIR"
}

setup_git() {
    if [ -z "$(git config --global user.name)" ] || [ -z "$(git config --global user.email)" ]; then
        info "-----> Git user not configured."
        read -p "Enter your Git name: " git_name
        read -p "Enter your Git email: " git_email

        git config --global user.name "$git_name"
        git config --global user.email "$git_email"
        success "-----> Git user configured."
    else
        info "-----> Git user already configured."
    fi
}

setup_macos () {
  if [ "$(uname -s)" = "Darwin" ]; then
    info "-----> Configuring OSX defaults..."
    sh -c  "$CONFIG_DIR/osx/defaults.sh"
  fi
}

# Main installation
main() {
    install_packages
    install_dotfiles
    install_zsh_plugins
    setup_git
    setup_macos
}

main
