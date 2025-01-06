# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export DOTFILES_LOADED="true"
export SHELL_NAME="zsh"

# Export path to root of dotfiles repo
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.dotfiles}
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

zsh_dir=$XDG_CONFIG_HOME/config/zsh

source $zsh_dir/exports.sh
source $zsh_dir/options.sh

# !! slow 500ms :(
source $ZSH/oh-my-zsh.sh

source $zsh_dir/aliases.sh
source $zsh_dir/functions.sh
# source $zsh_dir/paths.sh
source $zsh_dir/tools.sh
