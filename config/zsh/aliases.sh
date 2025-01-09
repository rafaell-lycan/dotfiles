#----------------------------------------
# shortcuts
#----------------------------------------
alias ls="ls --color=auto -F"
alias grep="grep --color=auto"
alias mkdir="mkdir -p -v"
alias less="less -r"
alias path='print -l $path'
alias dotfiles="code $DOTFILES"
alias pn='pnpm'
alias pubkey="cat ~/.ssh/id_ed25519.pub | pbcopy | printf '=> Public key copied to pasteboard.\n'"
alias jsonget="curl -X GET -H 'Accept: application/json'"
# https://github.com/ohmyzsh/ohmyzsh/issues/5243#issuecomment-253649851
alias reload!="exec zsh" # Quick reload of zsh environment

#----------------------------------------
# utils
#----------------------------------------
alias hex="openssl rand -hex"
alias ip='ifconfig | sed -En "s/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p"'
alias myip="curl https://ipinfo.io/json" # or /ip for plain-text ip
alias speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -"
alias serve='ruby -run -e httpd . -p 8000' # Or python -m SimpleHTTPServer :)
alias weather='curl -s v2.wttr.in'
