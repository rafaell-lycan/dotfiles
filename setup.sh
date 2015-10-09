#!/bin/sh

#
set -e

source log.sh

# -- Homebrew
# ----------------------------------------------------------------------
if which brew &>/dev/null; then
  msg_ok "homebrew"
else
  msg_run "homebrew" "ruby -e '$(curl -fsSLhttps://raw.github.com/mxcl/homebrew/go)'"
  ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
fi

# -- Git ----------------------------------------------------------------------
if which git &>/dev/null; then
  msg_ok "git"
else
  msg_run "git" "brew install git"
  brew install git
fi

# -- Dotfiles
# ----------------------------------------------------------------------
if [[ -d "$HOME/.dotfiles" ]]; then
  msg_ok "dotfiles"
else
  msg_run "dotfiles" "git clone https://github.com/mateusortiz/dotfiles.git $HOME/.dotfiles"
  git clone https://github.com/rafaell-lycan/dotfiles.git $HOME/.dotfiles
fi

# -- Installers
  cd "$HOME/.dotfiles/$(dirname $)"/..
  find . -name install.sh | while read installer ; do sh -c "${installer}" ; done

#echo "Set defaults evn"
#defaults write -g ApplePressAndHoldEnabled -bool false;
#defaults write com.apple.dashboard mcx-disabled -boolean true;
#killall Dock;

#echo "Installing oh-my-zsh"
#curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh

#echo "Installing Xcode command line tools"
#xcode-select --install

# Check for Homebrew,
# Install if we don't have it
#if test ! $(which brew); then
#  echo "Installing homebrew"
#  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
#fi

# Binaries instalation
#binaries=(
#  tmux
#  wget
#  htop-osx
#  openssl
#  icu4c
#  tree
#  sshfs
#  git
#  git-extras
#  nvm
#)

#echo "Installing binaries dependencies"
#brew install ${binaries[@]}

#echo "Installing last version of NVM"
#nvm install stable

#echo "Clean up..."
#brew cleanup

#echo "Installing PHP Env"
#brew install php56 --without-apache --with-fpm --with-homebrew-openssl --with-mssql --with-postgresql
#brew install phpunit
