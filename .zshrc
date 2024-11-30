export PATH="/opt/homebrew/bin:$PATH"

# Set up starship prompt
eval "$(starship init zsh)"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
