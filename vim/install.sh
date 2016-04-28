#!/bin/sh
source $HOME/.dotfiles/log.sh

# -- Vim
# ----------------------------------------------------------------------
if which vim &>/dev/null; then
  msg_ok "vim"
else
  msg_run "vim" "brew install vim"
  brew install vim
fi

# -- Config
# ----------------------------------------------------------------------
if [[ -L "$HOME/.vimrc" ]]; then
  msg_ok ".vimrc"
else
  msg_run ".vimrc" "ln -s $HOME/.dotfiles/vim/.vimrc $HOME/.vimrc"
  ln -s $HOME/.dotfiles/vim/.vimrc $HOME/.vimrc
fi

# -- Plugins
# ----------------------------------------------------------------------
if [[ -d "$HOME/.vim" ]]; then
  msg_ok ".vim"
else
  msg_run ".vim" "Installing VundleVim"
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  
  msg_run ".vim" "ln -s $HOME/.dotfiles/vim/.vim $HOME/.vim"
  ln -s $HOME/.dotfiles/vim/.vim $HOME/.vim
fi
