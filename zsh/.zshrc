########
# See this posts  http://zanshin.net/2013/02/02/zsh-configuration-from-the-ground-up/
#                 http://www.stevendobbelaere.be/installing-and-configuring-the-oh-my-zsh-shell/
#                 https://www.codementor.io/linux/tutorial/configure-linux-toolset-zsh-tmux-vim
#                 https://dustri.org/b/my-zsh-configuration.html
#                 http://zanshin.net/2011/08/12/oh-my-zsh/
#                 https://github.com/zanshin/dotfiles/
#                 https://github.com/thoughtbot/dotfiles/
########
# Path to your oh-my-zsh installation.
export ZSH=/Users/rafaell/.oh-my-zsh

# ZSH_THEME="robbyrussell"
ZSH_THEME="robbyrussell"

plugins=(git git-extras brew pip gem node npm osx tmux python rake ruby zsh-syntax-highlighting vagrant)

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# load all of the configs in ~/dotfiles/zsh/* in .zsh
for config_file ($HOME/.dotfiles/zsh/*.zsh) source $config_file
