echo "Set defaults evn"
defaults write -g ApplePressAndHoldEnabled -bool false;
defaults write com.apple.dashboard mcx-disabled -boolean true;
killall Dock;

echo "Installing oh-my-zsh"
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh

echo "Installing homebrew"
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Installing brew dependencies"
brew install tmux
brew install htop-osx
brew install openssl
brew install wget
brew install git
brew install nvm

echo "Installing last version of NVM"
nvm install stable