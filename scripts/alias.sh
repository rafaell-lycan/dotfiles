# Alias script
#
# Thanks to @mv and @fnando

# Reload scripts
alias rsrc='source ~/.bash/init.sh'

# Interactive operations
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# Show differences in colour
alias grep='egrep --color'

# Lists
alias ls='ls -hFG'
alias  l='ls'
alias ll='ls -l'     # long list
alias la='ls -A'     # all but . and ..

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

# MacOS log
alias msg='tail -f /var/log/system.log'

# Dir shortcuts
alias  s='cd ~/Sites'
alias ss='cd ~/Sites/sandbox'

# Bin
alias be='bundle exec'
alias ccbare='compass create . --bare --sass-dir "stylesheets/sass" --css-dir "stylesheets" --javascripts-dir "javascripts" --images-dir "images"'
alias ccdev='compass compile -e development --force'
alias ccprod='compass compile -e production --force'
alias ccw='compass watch'
alias mdm='middleman server --reload-paths=helpers'

# Cool stuff
alias jsonget="curl -X GET -H 'Accept: application/json'"

# Generates a RTF colored output using Pygments - http://pygments.org/
function colorize () { pygmentize -f rtf -O "style=colorful,fontface=Monaco" "$1" | pbcopy; }

# Locks the mac
alias lockmac='/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend'

# Converts a given .mov to a GIF
# https://gist.github.com/dergachev/4627207
function movtogif () { ffmpeg -i $1 -vf scale=480:-1 -pix_fmt rgb24 -r 24 -f gif - | gifsicle --optimize=3 --delay=3 > converted.gif; }