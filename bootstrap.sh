#!/bin/sh
#
# Tells the shell script to exit if it encounters an error
set -e

cd "$(dirname $0)"

# Log
info () {
  printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

user () {
  printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}
# ---

# Hello :)
info '                   '
info '     | |     | |  / _(_) |           '
info '   __| | ___ | |_| |_ _| | ___  ___  '
info '  / _` |/ _ \| __|  _| | |/ _ \/ __| '
info ' | (_| | (_) | |_| | | | |  __/\__ \ '
info '  \__,_|\___/ \__|_| |_|_|\___||___/ '
info '                   '

# Homebrew
if test "$(which homebrew)"; then
  info "* Installing Homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
# ---

# Install all packages in the Brewfile
echo "* Installing all packages in Brewfile..."
brew update
brew bundle -v
brew cleanup
brew cask cleanup

# ---

run_installers () {
  local config_dir="$(pwd -P)/configs"

  # Some installers need to run first (e.g. ruby, to install a rbenv ruby)
  local prioritized=('ruby')

  for installer in ${prioritized}; do
    echo "  - $p/install.sh"
    sh -c "$config_dir/$installer/install.sh"
  done

  # Find the rest of the installers and run them iteratively; order doesn't matter.
  local installers=$(ls configs/**/install.sh | grep -v -F $prioritized)

  # load the path files
  for installer in ${installers}; do
    conf="$(basename $(dirname ${installer}))"
    name=$(basename $(dirname ${installer}))/$(basename ${installer})
    echo "  - $name"
    sh -c "${installer}"
  done
}

echo "* Running all installers..."
run_installers

echo ""
echo "* All done!"
