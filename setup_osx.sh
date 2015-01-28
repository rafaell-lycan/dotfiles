echo "Set defaults evn"
defaults write -g ApplePressAndHoldEnabled -bool false;
defaults write com.apple.dashboard mcx-disabled -boolean true;
killall Dock;

echo "Installing oh-my-zsh"
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh

echo "Installing homebrew"
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Installing Xcode command line tools"
xcode-select --install

echo "Installing brew dependencies"
brew install tmux
brew install htop-osx
brew install openssl
brew install icu4c
brew install wget
brew install git
brew install git-extras

echo "Installing last version of NVM"
brew install nvm
nvm install stable

echo "Installing PHP Env"
brew install php56 --without-apache --with-fpm --with-homebrew-openssl --with-mssql --with-postgresql
brew install phpunit