#!/bin/sh

# Tells the shell script to exit if it encounters an error
set -e

# -- Log
# Duplicated code from log.sh
# since we cannot import a file when installing via cURL

function msg {
  echo  "\033[0;37m$1\033[0m";
}

function msg_ok {
  echo  "➜\033[1;32m $1 ✔\033[0m";
}

function msg_run {
  echo  "➜\033[1;35m $1 $ $2\033[0m";
}

function msg_done {
  echo  "➜\033[1;37m $1 \033[0m";
}

# -- Hello :) ------------------------------------------------------------------
msg '									                    ' 
msg '     | |     | |  / _(_) |           '
msg '   __| | ___ | |_| |_ _| | ___  ___  '
msg '  / _` |/ _ \| __|  _| | |/ _ \/ __| '
msg ' | (_| | (_) | |_| | | | |  __/\__ \ '
msg '  \__,_|\___/ \__|_| |_|_|\___||___/ '
msg '									                    ' 

# -- Homebrew ------------------------------------------------------------------
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

# -- Dotfiles ------------------------------------------------------------------
if [[ -d "$HOME/.dotfiles" ]]; then
  msg_ok "dotfiles"
else
  msg_run "dotfiles" "git clone https://github.com/mateusortiz/dotfiles.git $HOME/.dotfiles"
  git clone https://github.com/rafaell-lycan/dotfiles.git $HOME/.dotfiles
fi

# -- Installers ------------------------------------------------------------------
# Find the installers and run them iteratively
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
