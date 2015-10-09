#!/bin/sh
source $HOME/.dotfiles/log.sh

# -- Tmux
# ----------------------------------------------------------------------
if which tmux &>/dev/null; then
  msg_ok "tmux"
else
  msg_run "tmux" "brew install tmux"
  brew install tmux
fi

# -- Config¬
# ----------------------------------------------------------------------
if [[ -L "$HOME/.tmux.conf" ]]; then¬
  msg_ok ".tmux.conf"
else
  msg_run ".tmux.conf" "ln -s $HOME/.dotfiles/tmux/.tmux.conf $HOME/.tmux.conf"
  ln -s $HOME/.dotfiles/tmux/.tmux.conf $HOME/.tmux.conf
fi

# -- Plugins
#----------------------------------------------------------------------
if [[ -d "$HOME/.tmux" ]]; then¬
  msg_ok ".tmux"
else
  msg_run ".tmux" "ln -s $HOME/.dotfiles/tmux/.tmux $HOME/.tmux"
  ln -s $HOME/.dotfiles/tmux/.tmux $HOME/.tmux
fi
