#!/bin/sh
source $HOME/.dotfiles/log.sh

# -- Rbenv
# ----------------------------------------------------------------------
if which rbenv &> /dev/null; then
  msg_ok "rbenv"
else
  msg_run "rbenv" "git clone https://github.com/sstephenson/rbenv.git $HOME/.rbenv"
  brew install rbenv 
fi

# -- Ruby Build
# ----------------------------------------------------------------------

if [ -d "$HOME/.rbenv/plugins/ruby-build" ]; then
  msg_ok "ruby-build"
else
  msg_run "ruby-build" "git clone https://github.com/sstephenson/ruby-build.git $HOME/.rbenv/plugins/ruby-build"
  git clone https://github.com/rbenv/ruby-build.git $HOME/.rbenv/plugins/ruby-build
fi
