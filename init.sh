# Copy dotfiles folder from $HOME directory
cp -Rv $(pwd) $HOME

# Configure OSX
source $HOME/dotfiles/setup_osx.sh

# Install Apps via Cask
source $HOME/dotfiles/scripts/apps.sh

# Configure other stuffs
source $HOME/dotfiles/scripts/alias.sh
source $HOME/dotfiles/scripts/git-completion.sh

# Copy some config files
cp $HOME/dotfiles/scripts/.gitconfig $HOME/.gitconfig
cp $HOME/dotfiles/scripts/.gitignore_global $HOME/.gitignore_global
cp $HOME/dotfiles/scripts/.bash_profile $HOME/.bash_profile
cp $HOME/dotfiles/scripts/.zshrc $HOME/.zshrc
cp $HOME/dotfiles/scripts/.bashrc $HOME/.bashrc