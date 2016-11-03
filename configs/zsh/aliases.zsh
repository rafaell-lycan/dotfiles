# Reload shell
alias reload!='. ~/.zshrc'

# Lists
alias ls='ls -hFG'
alias  l='ls'
alias ll='ls -l'     # long list
alias la='ls -A'     # all but . and ..

# Misc
alias grep='egrep --color'
alias less="less -r"
alias hostsfile='e /etc/hosts'

# Pipe public key to clipboard.
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | printf '\n\r\033[2K  [ \033[00;32mPublic key copied to pasteboard.\033[0m ] id_rsa.pub\n\n'"

# PostgreSQL controlling
alias pgstart='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias  pgstop='pg_ctl -D /usr/local/var/postgres stop -s -m fast'

# MongoDB
alias mongostart='mongod run'

# Redis
alias redisstart='redis-server /usr/local/etc/redis.conf'

# Elasticsearch
alias esstart="elasticsearch -f"

# MySQL controlling
alias mysqlstart='launchctl load -w ~/Library/LaunchAgents/com.mysql.mysqld.plist'
alias  mysqlstop='launchctl unload -w ~/Library/LaunchAgents/com.mysql.mysqld.plist'

# Cool stuff
alias jsonget="curl -X GET -H 'Accept: application/json'"

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"