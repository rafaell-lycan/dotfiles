md() {
  mkdir -p "$1" && cd "$1";
}

cd() {
  builtin cd "${@:-$HOME}" && pwd > $CDHISTORY;
}

popd() {
  builtin popd && pwd > $CDHISTORY;
}

pushd() {
  builtin pushd && pwd > $CDHISTORY;
}

if [ -f $CDHISTORY ]; then
   DIR=$(cat $CDHISTORY)

   if [ -d "$DIR" ]; then
    cd "$DIR"
   fi
fi

if [ ! -f $CDHISTORY ]; then              # Only autocd when the $CDHISTORY file
  if [ -d /Projects ]; then               # cannot be found. In this case, try
    cd /Projects                          # to find the /Projects directory,
  elif [ -d /vagrant ]; then              # defaulting to the vagrant directory.
    cd /vagrant
  fi
fi

function rscp() {
  rsync -vr --partial --progress -e ssh $1 $2
}

psgrep() {
  if [[ $# == 0 ]]; then
    echo 'Usage: psgrep <process name>'
    return 1
  fi

  output=$(ps aux)
  header=$(echo $output | head -n1)
  matches=$(echo -n $output | grep -v grep | grep $1)

  if [[ "$matches" != "" ]]; then
    echo $header
    echo $matches
    return 0
  fi

  return 2
}
