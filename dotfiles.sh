#!/bin/bash
#
# Run all dotfiles installers.

set -e

export PATH="$HOME/.dotfiles:$PATH"

export DOTFILES_ROOT="$HOME/.dotfiles"

link_file () {
  local src=$1 dst=$2

  local overwrite= backup= skip=
  local action=

  if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]; then
    if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]; then
      local currentSrc="$(readlink $dst)"

      if [ "$currentSrc" == "$src" ]; then
        skip=true
      else
        user "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
        [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
        read -n 1 action

        case "$action" in
          o )
            overwrite=true;;
          O )
            overwrite_all=true;;
          b )
            backup=true;;
          B )
            backup_all=true;;
          s )
            skip=true;;
          S )
            skip_all=true;;
          * )
            ;;
        esac
      fi
    fi

    overwrite=${overwrite:-$overwrite_all}
    backup=${backup:-$backup_all}
    skip=${skip:-$skip_all}

    if [ "$overwrite" == "true" ]; then
      rm -rf "$dst"
      success "removed $dst"
    fi

    if [ "$backup" == "true" ]; then
      mv "$dst" "${dst}.backup"
      success "moved $dst to ${dst}.backup"
    fi

    if [ "$skip" == "true" ]; then
      success "skipped $src"
    fi
  fi

  if [ "$skip" != "true" ]; then  # "false" or empty
    ln -s "$1" "$2"
    success "linked $1 to $2"
  fi
}

install_dotfiles () {
  local overwrite_all=false backup_all=false skip_all=false

  for src in $(find -H "$DOTFILES_ROOT/configs" -maxdepth 2 -name '*.symlink' -not -path '*.git*'); do
    echo "$HOME/.$(basename "${src%.*}")"
    dst="$HOME/.$(basename "${src%.*}")"
    link_file "$src" "$dst"
  done
}

run_installers () {
  echo "install"
  local config_dir="$DOTFILES_ROOT/configs"

  # Some installers need to run first (e.g. ruby, to install a rbenv ruby)
  local prioritized=('ruby')

  for installer in ${prioritized}; do
    echo "  - $p/install.sh"
    sh -c "$config_dir/$installer/install.sh"
  done

  # Find the rest of the installers and run them iteratively; order doesn't matter.
  local installers=$(ls $DOTFILES_ROOT/configs/**/install.sh | grep -v -F $prioritized)

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

# Grab all submodules before moving on
info "Initializing submodules..."
git submodule update --init --recursive

# Install the dot files
info "Installing dotfiles..."
install_dotfiles

# Change ZSH as default shell
chsh -s /bin/zsh

echo ""
echo "Done!"