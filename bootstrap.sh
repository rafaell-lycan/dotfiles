#!/bin/sh
#
# Tells the shell script to exit if it encounters an error
# set -e

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
}
# ---

# Hello :)
info '                   '
info '     | |     | |  / _(_) |           '
info '   __| | ___ | |_| |_ _| | ___  ___  '
info '  / _` |/ _ \| __|  _| | |/ _ \/ __| '
info ' | (_| | (_) | |_| | | | |  __/\__ \ '
info '  \__,_|\___/ \__|_| |_|_|\___||___/ '
info ' 

# ---'

# Dotfiles
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.
[[ "$(uname -s)" != "Darwin" ]] && exit 0

DOTFILES_ROOT="$HOME/.dotfiles"

uninstallHomebrew() {
  # Uninstall Homebrew
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
}

installHomebrew() {
  # Install Homebrew
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

# Check for Homebrew
if test ! "$(which brew)"; then
  user "  Would like to install Homebrew? [y/n] "
  read -r -e answer

  if [ "$answer" = "y" ]; then
    echo "  Installing Homebrew for you..."
    installHomebrew
  fi
else
  if test "$(which brew)"; then
    user "  Would like to re-install Homebrew? [y/n] "
    read -r -e answer

    if [ "$answer" = "y" ]; then
      uninstallHomebrew
      installHomebrew
    fi
  fi
fi

if test "$(which brew)"; then
  user "  Would like to update, upgrade and cleanup Homebrew? [y/n] "
  read -r -e answer

  if [ "$answer" = "y" ]; then
    info " Running 'brew update'..."
    brew update
    info " Running 'brew upgrade'..."
    brew upgrade
    info " Running 'brew cleanup'..."
    brew cleanup
    brew prune
  fi
fi
# ---

# clone the project
if [ ! -d "$DOTFILES_ROOT" ]; then
  if test "$(which brew)"; then
    info "* Installing Git..."
    brew install git
  fi
  info "* Downloading Dotfiles..."
  git clone https://github.com/rafaell-lycan/dotfiles.git $DOTFILES_ROOT
fi
# ---

cd $DOTFILES_ROOT

# common dependencies from Brewfile
if test "$(which brew)"; then
  echo -e "
    Common dependencies:
    ffmpeg, gifsicle, git, grc, bash-completion, m-cli, nvm,
    coreutils, diff-so-fancy, bash-git-prompt, yarn (without-node)
  "
  user "  Would like to install common dependencies? [y/n] "
  read -r -e answer
  
  if [ "$answer" = "y" ]; then
    brew bundle -v
  fi
fi

. "$DOTFILES_ROOT/dotfiles.sh"
success "* All done!"
