# Install some apps with Homebrew Cask
echo "Installing Homebrew Cask"
brew install caskroom/cask/brew-cask

echo "Update caskroom versions"
brew tap caskroom/versions
brew tap phinze/homebrew-cask

apps=(
  alfred
  coconutbattery
  dropbox
  evernote
  firefox
  flash
  filezilla
  google-chrome
  google-chrome-canary
  iterm2
  limechat
  mailbox
  phpstorm
  screenflow
  slack
  skype
  smcfancontrol
  sourcetree
  spotify
  sublime-text3
  the-unarchiver
  utorrent
  vagrant
  valentina-studio
  virtualbox
  vlc
)

# Install apps to /Applications
# Default is: /Users/$USER/Applications
echo "installing apps..."
brew cask install --appdir="/Applications" ${apps[@]}

# Link the folder to alfred preferences
echo "Add into Alfred Default Results this path: \n \n"
echo "Go to: /opt/homebrew-cask/Caskroom/ \n \n"

echo "Clean up..."
brew cask cleanup