
# Deletes the current directory's generated files and reinstalls Node modules.
trashy() {
  printf "🟡 Deleting generated files...\n"
  rm -rf .cache/ .next/ .turbo/ build/ coverage/ dist/ node_modules/ out/ public/build storybook-static/ .eslintcache .stylelintcache
  printf "🟡 Deleted generated files.\n"
  read "DeleteLockFiles?🟡 Delete npm, pnpm, or yarn lockfiles? [y/n]: "
    if [[ "$DeleteLockFiles" =~ ^[Yy]$ ]] then
      printf "🟡 Deleting lockfiles...\n"
      rm -rf package-lock.json pnpm-lock.yaml yarn.lock
      printf "🟡 Deleted lockfiles.\n"
  fi
  read "PackageManager?🟡 Install packages via npm, pnpm, or yarn? [n/p/y]: "
  if [[ "$PackageManager" =~ ^[Yy]$ ]] then
    printf "🟡 Installing packages via yarn...\n"
    yarn install
  elif [[ "$PackageManager" =~ ^[Pp]$ ]] then
    printf "🟡 Installing packages via pnpm...\n"
    pnpm install
  else
    printf "🟡 Installing packages via npm...\n"
    npm install
  fi
}

# Kill all related processes.
killps() {
  printf "🟡 Killing processes...\n"
  kill `ps -ef | grep $1 | awk '{print $2}'`
  printf "🟡 Restart affected applications!\n"
}

# Kill process on a specific port.
killport() {
  if [ -z "$1" ]; then
    printf "🔴 Please provide a port number!\n"
    return 1
  fi
  printf "🟡 Killing process on port $1...\n"
  # verify that the port is in use before killing it
  if ! lsof -i :$1 | grep LISTEN; then
    printf "🔴 Port $1 is not in use!\n"
    return 1
  else
    kill `lsof -i :$1 | grep LISTEN | awk '{print $2}'`
    printf "🟡 Restart affected applications!\n"
  fi
}


GIT_PERSONAL_NAME="Rafaell Lycan"
GIT_PERSONAL_EMAIL="sonny.webdsg@gmail.com"
GIT_WORK_NAME="Rafael Almeida"
GIT_WORK_EMAIL="rafael.almeida@typeform.com"

# Display Git user information
git_whoami() {
  local repo_name=$(git rev-parse --show-toplevel 2>/dev/null | xargs basename)
  local repo_user=$(git config user.name 2>/dev/null)
  local repo_email=$(git config user.email 2>/dev/null)
  local global_user=$(git config --global user.name)
  local global_email=$(git config --global user.email)

  if [[ -n "$repo_name" ]]; then
    printf "🗂️  Repo (%s): 🧑‍💻 \e[1m%s\e[0m <%s>\n" "$repo_name" "$repo_user" "$repo_email"
  fi
  printf "🌍 Global: 🧑‍💻 \e[1m%s\e[0m <%s>\n" "$global_user" "$global_email"
}

# Switch Git user profile
git_switch_user() {
  git_whoami

  printf "\nChoose a Git user profile:\n"
  printf "(1) Personal (%s)\n" "$GIT_PERSONAL_NAME"
  printf "(2) Work (%s)\n" "$GIT_WORK_NAME"
  printf "(q) Quit\n"

  read "choice?🟡 Enter your choice [1/2/q]: "

  case $choice in
    1)
      local new_name="$GIT_PERSONAL_NAME"
      local new_email="$GIT_PERSONAL_EMAIL"
      ;;
    2)
      local new_name="$GIT_WORK_NAME"
      local new_email="$GIT_WORK_EMAIL"
      ;;
    [Qq])
      printf "🚫 Operation cancelled.\n"
      return
      ;;
    *)
      printf "🔴 Invalid choice. Operation cancelled.\n"
      return
      ;;
  esac

  command git config user.name "$new_name"
  command git config user.email "$new_email"

  printf "\n🟢 Git user changed.\n"

  # printf "🟡 You can also change your global Git user configuration.\n"
  # read "confirm?🟡 Do you want to proceed? [y/n]: "
  # if [[ $confirm =~ ^[Yy]$ ]]; then
  #   command git config --global user.name "$new_name"
  #   command git config --global user.email "$new_email"
  #   printf "🟢 Git user changed globally.\n"
  # else
  #   printf "🚫 Global change cancelled.\n"
  #   return
  # fi

  git_whoami
}

# Prints out versions of core Node.js packages
print_node_versions () {
  versions=''

  format_verion_number () {
    echo "$($1 --version 2>&1 | head -n 1 | sed 's/[^0-9.]*//g')"
  }

  get_version () {
    if hash $1 2> /dev/null || command -v $1 >/dev/null; then
      versions="$versions\e[36m\e[1m $2: \033[0m$(format_verion_number $1) \n\033[0m"
    else
      versions="$versions\e[33m\e[1m $2: \033[0m\033[3m Not installed\n\033[0m"
    fi
  }

  # Source NVM if not yet done
  if typeset -f source_nvm > /dev/null && source_nvm

  # Print versions of core Node things
  get_version 'node' 'Node.js'
  get_version 'npm' 'NPM'
  get_version 'yarn' 'Yarn'
  get_version 'pnpm' 'pnpm'
  get_version 'bun' 'Bun'
  get_version 'deno' 'Deno'
  get_version 'nvm' 'NVM'
  get_version 'git' 'Git'
  echo -e $versions
}

p() {
  if [[ -f bun.lockb ]]; then
    command bun "$@"
  elif [[ -f pnpm-lock.yaml ]]; then
    command pnpm "$@"
  elif [[ -f yarn.lock ]]; then
    command yarn "$@"
  elif [[ -f package-lock.json ]]; then
    command npm "$@"
  else
    command pnpm "$@"
  fi
}

timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}
