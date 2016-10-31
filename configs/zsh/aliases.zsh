# Reload shell
alias reload!='. ~/.zshrc'

# Lists
alias ls='ls -hFG'
alias  l='ls'
alias ll='ls -l'     # long list
alias la='ls -A'     # all but . and ..

# Show differences in colour
alias grep='egrep --color'

# Pipe public key to clipboard.
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"
