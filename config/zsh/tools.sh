# --------------- init tools ----------------
# Per-directory configs
if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

# Like cd but with z-zsh capabilities
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init --hook pwd --cmd cd zsh)"
fi

# Like nvm but faster
if command -v fnm >/dev/null 2>&1; then
  eval "$(fnm env --use-on-cd --shell zsh)"
  eval "$(fnm completions --shell zsh)"
  alias nvm="fnm" # Use fnm as nvm
fi

# --------------- load zsh files ----------------
# Fuzzy finder bindings
if [ -f "$HOME/.fzf.zsh" ]; then
  # eval "$(fzf --zsh)" # This is slow
  source "$HOME/.fzf.zsh"
  export FZF_DEFAULT_OPTS='--height 40% --layout=reverse'
  export FZF_DEFAULT_COMMAND='fd --type file --hidden -L'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# Bun completions
if [ -s "$HOME/.bun/_bun" ]; then
  source "$HOME/.bun/_bun"
  export BUN_INSTALL="$HOME/.bun"
  export PATH="$BUN_INSTALL/bin:$PATH"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
