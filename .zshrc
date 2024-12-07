export PATH="/opt/homebrew/bin:$PATH"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

alias reload-zsh="source ~/.zshrc"
alias edit-zsh="nvim ~/.zshrc"

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history 
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH=$PATH:/Users/joseanmartinez/.spicetify

export PATH="$HOME/.rbenv/shims:$PATH"

# ---- FZF -----

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

export FZF_DEFAULT_OPTS='--height 90% --layout=reverse --border=none --no-separator --no-scrollbar --info=hidden' # --color=bg+:-1 to hide selected item bg

# -- Use fd instead of fzf --

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_R_OPTS="--prompt 'History > ' --with-nth 2.."
export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"
alias cd="z"

# ---- Random Aliases ----
alias vim='nvim'
alias ls='eza -1 --icons -s ext --group-directories-first'
alias la='ls --all'
alias lt='eza --git-ignore -T --icons -s ext --group-directories-first'
alias cat='bat'
alias rust_run_watch='cargo watch -c -d 0 -x run'
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias _cpr='gh pr create --fill-first' # create PR
alias cpr='_cpr | pbcopy' # create PR and copy url
alias cprd='_cpr --draft | pbcopy' # create draft PR and copy url
alias list_projects='find ~/Desktop ~/Desktop/work ~/Desktop/personal ~/.config -mindepth 1 -maxdepth 1 -type d | fzf'
alias p='cd $(list_projects || pwd)' # CD into a project
alias c='code $(list_projects) -r' # Open a project in VSCode
alias brewdump='cd ~ && brew bundle dump --casks --taps --brews --force && cd -'
alias lg='lazygit'
alias ld='lazydocker'
alias ln='lazynpm'

# ---- Docker Helpers ----
docker_compose="docker compose -f docker-compose.yml -f docker-compose.debug.yml"

function _get_service() {
  local service=$1
  if [ -z "$service" ]; then
    service=$(docker compose ps --services | fzf)
  fi
  echo $service
}

function dcl() {
  local service=$(_get_service $1)
  eval $docker_compose logs $service -f --tail 100
}
function dcr() {
  local service=$(_get_service $1)
  eval $docker_compose up $service --force-recreate -d && dcl $service
}
function dcb() {
  local service=$(_get_service $1)
  eval $docker_compose build $service && dcr $service
}
function dcu() {
  local service=$(_get_service $1)
  eval $docker_compose up $service -d && dcl $service
}