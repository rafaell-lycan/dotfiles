alias hex="openssl rand -hex"
alias path='print -l $path'
alias grep="grep --color=auto"
alias mkdir="mkdir -p -v"
alias less="less -r"
alias dotfiles="code $DOTFILES"
alias ip='ifconfig | sed -En "s/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p"'
# alias myip="curl https://ipinfo.io/json" # or /ip for plain-text ip
alias speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -"
alias serve='ruby -run -e httpd . -p 8000' # Or python -m SimpleHTTPServer :)
alias pn='pnpm'
alias pubkey="cat ~/.ssh/id_rsa.pub | pbcopy | printf '=> Public key copied to pasteboard.\n'"
alias weather='curl http://wttr.in/barcelona?m'
alias jsonget="curl -X GET -H 'Accept: application/json'"
alias reload!="source ~/.zshrc" # Quick reload of zsh environment
