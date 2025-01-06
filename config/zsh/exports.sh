if [[ "$(uname -m)" == "arm64" ]]; then
  export HOMEBREW_PREFIX=/opt/homebrew
else
  export HOMEBREW_PREFIX=/usr/local
fi

export REACT_EDITOR=code
export BUNDLER_EDITOR=code
export GEM_EDITOR="code"
export EDITOR="code -w"
export VISUAL="$EDITOR"

export PAGER='less'
export LESS="-REX"
export KEYTIMEOUT=10
export WORDCHARS='*?[]~$^()}<>'

# The path to the history file.
export HISTFILE=$HOME/.zsh_history
# The maximum number of events to save in the internal history.
export HISTSIZE=10000
# The maximum number of events to save in the history file.
export SAVEHIST=$HISTSIZE
export HISTCONTROL=ignoreboth:erasedups
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"

export ERL_AFLAGS="-kernel shell_history enabled"

# Encoding stuff for the terminal
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# enable colored output from ls, etc. on FreeBSD-based systems
export TERM=xterm-256color CLICOLOR=1

export HOMEBREW_CASK_OPTS="--appdir=/Applications --fontdir=~/Library/Fonts"
export HOMEBREW_BUNDLE_NO_LOCK=1
export HOMEBREW_BUNDLE_DUMP_NO_VSCODE=1
export HOMEBREW_BUNDLE_DUMP_DESCRIBE=1
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=1
