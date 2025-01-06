zmodload zsh/zprof

#----------------------------------------
# general options
#----------------------------------------
# never ever beep <-
setopt no_beep
# cd by typing directory name if it's not a command <-
setopt auto_cd
# autocorrect commands
setopt correct_all
# automatically list choices on ambiguous completion
setopt auto_list
# automatically use menu completion <-
setopt auto_menu
# move cursor to end if word had one match
setopt always_to_end

zstyle ':omz:plugins:nvm' lazy yes
zstyle ':omz:plugins:nvm' silent-autoload yes

# updates oh-my-zsh every 30 days
zstyle ':omz:update' mode auto  # :auto; disabled; reminder
zstyle ':omz:update' frequency 30

#----------------------------------------
# history options
#----------------------------------------
# remove older duplicate entries from history
setopt hist_ignore_all_dups
# remove superfluous blanks from history items
setopt hist_reduce_blanks
# save history entries as soon as they are entered
setopt inc_append_history
# share history between different instances of the shell
setopt share_history

#----------------------------------------
# completion options
#----------------------------------------
# case insensitive tab completion
# zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
# colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# automatically find new executables in path
zstyle ':completion:*' rehash true
# select completions with arrow keys
zstyle ':completion:*' menu yes select
# group results by category
zstyle ':completion:*' group-name ''
# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending
# enable approximate matches for completion
zstyle ':completion:*' completer _expand _expand_alias _complete _correct _ignored _approximate

zstyle ':completion:*:default' list-prompt '%S%M matches%s'

# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.tmp/.zsh-cache

#----------------------------------------
# plugin options
#----------------------------------------
plugins=(
  gitfast
  zsh-autosuggestions # [1]
  history-substring-search # [0]
  zsh-syntax-highlighting # Warning: Must be last sourced!
)

# plugin configuration
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=white"
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export HISTORY_SUBSTRING_SEARCH_FUZZY=1
export HISTORY_SUBSTRING_SEARCH_PREFIXED=1
