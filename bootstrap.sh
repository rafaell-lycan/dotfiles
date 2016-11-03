#!/bin/sh
#
# Tells the shell script to exit if it encounters an error
set -e

DOTFILES_ROOT="$HOME/.dotfiles"

# Log
info () {
  printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

user () {
  printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}
# ---

# Hello :)
info '                   '
info '     | |     | |  / _(_) |           '
info '   __| | ___ | |_| |_ _| | ___  ___  '
info '  / _` |/ _ \| __|  _| | |/ _ \/ __| '
info ' | (_| | (_) | |_| | | | |  __/\__ \ '
info '  \__,_|\___/ \__|_| |_|_|\___||___/ '
info '                   '

# Homebrew
if test "$(which homebrew)"; then
  info "* Installing Homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
# ---

# Git
if test "$(which homebrew)"; then
  info "* Installing Git..."
  brew install git
fi
# ---

# Dotfiles
if [ ! -d "$DOTFILES_ROOT" ]; then
  info "* Downloading Dotfiles..."
  git clone https://github.com/rafaell-lycan/dotfiles.git $DOTFILES_ROOT
fi
# ---

# Install all packages in the Brewfile
echo "* Installing all packages in Brewfile..."
cd $DOTFILES_ROOT
brew update
brew bundle -v
brew cleanup
brew cask cleanup
# ---

. "$DOTFILES_ROOT/dotfiles.sh"

echo ""
echo "* All done!"
