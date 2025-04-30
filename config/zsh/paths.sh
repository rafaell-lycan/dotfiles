# for deno
# export PATH="$PATH:$HOME/.deno/bin"

# bun
# export PATH="$PATH:$HOME/.bun/bin"

# code
VSCODE_PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
if [ -d "$VSCODE_PATH" ]; then
  export PATH="$PATH:$VSCODE_PATH"
fi

# pnpm
export PNPM_HOME="/Users/rafael.almeida/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
