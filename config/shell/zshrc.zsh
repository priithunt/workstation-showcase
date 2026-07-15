# A curated interactive subset. Machine-specific paths stay in the private
# template; this file focuses on navigation and editing policy.

export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="wezterm"

path=(
  "$HOME/.local/bin"
  "$HOME/.local/share/mise/shims"
  $path
)
typeset -U path PATH
export PATH

alias ls='eza --icons=always'
alias la='eza -lAh --icons=always'
alias lg='eza -lAh --git --icons=always'

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
  alias cd="z"
fi

if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh)
fi

if command -v atuin >/dev/null 2>&1; then
  eval "$(atuin init zsh --disable-up-arrow --disable-ai)"
fi

# Activate reviewed shared runtimes after the base PATH is established.
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
  mise_java_home="$(mise where java 2>/dev/null)" || mise_java_home=""
  if [[ -n "$mise_java_home" ]]; then
    export JAVA_HOME="$mise_java_home"
  fi
  unset mise_java_home
fi

HISTFILE="$HOME/.zhistory"
SAVEHIST=50000
HISTSIZE=50000
setopt share_history inc_append_history hist_expire_dups_first hist_ignore_dups hist_verify

bindkey -v
KEYTIMEOUT=20
bindkey -M viins 'jk' vi-cmd-mode
bindkey -M viins '^A' beginning-of-line
bindkey -M viins '^E' end-of-line
bindkey -M viins '^L' clear-screen
bindkey -M vicmd '^L' clear-screen

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line
