# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Load zsh-completions
autoload -Uz compinit && compinit

# Recommended in docs
zinit cdreplay -q

# Configure fzf-tab
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --icons -s ext --group-directories-first $realpath'
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' fzf-flags --height 90%

# add homebrew to path
export PATH="/opt/homebrew/bin:$PATH"
# add scripts to path
export PATH="$HOME/.scripts:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

alias reload-zsh="source ~/.zshrc"
alias edit-zsh="nvim ~/.zshrc"

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
HISTORY_IGNORE="*ms-vscode.js-debug*"
setopt share_history 
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# ---- lazy NVM ----

function nvm () {
  unfunction nvm
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
  nvm use
}

# ---- FZF -----

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

export FZF_DEFAULT_OPTS='--height 90% --layout=reverse --border=none --no-separator --no-scrollbar --info=hidden --bind ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down'

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


# ---- Exports ----
export EDITOR="cursor --wait"
export EZA_CONFIG_DIR="$HOME/.config/eza"
export JIRA_API_TOKEN=$(cat ~/.jira_token)

# ---- Aliases ----
alias nvim="$HOME/bin/nvim-macos/bin/nvim"
alias vim='nvim'
alias ls='eza -x --icons -s name --group-directories-first'
alias la='ls --all'
alias lt='eza --git-ignore -T --icons -s ext --group-directories-first'
alias cat='bat'
alias rust_run_watch='cargo watch -c -d 0 -x run'
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias _cpr='gh pr create --fill-first' # create PR
alias cpr='_cpr | pbcopy' # create PR and copy url
alias cprd='_cpr --draft | pbcopy' # create draft PR and copy url
alias list_projects='find ~/Desktop ~/Desktop/work ~/Desktop/personal ~/.config -mindepth 1 -maxdepth 1 -type d | fzf --preview="eza -1 --icons -s ext --group-directories-first {}"'
alias p='cd $(list_projects || pwd)' # CD into a project
alias c='cursor -r'  
alias cp='c $(list_projects)' # Open a project in Cursor
alias brewdump='cd ~ && brew bundle dump --casks --taps --brews --force && cd -'
alias lg='lazygit'
# alias ld='DOCKER_HOST=unix:///Users/omercohen/.colima/default/docker.sock lazydocker'
alias ld='lazydocker'
alias ln='lazynpm'
alias deploy='sh ~/.scripts/deploy.sh'
alias gd='gh dash'
alias gm='git pull --no-rebase origin'
alias gmm='gm main'
alias gp='git push --no-verify'
alias grl='git reset HEAD~'
alias ghpr='gh pr view --web'

gc() {
  git add -A && git commit --no-verify -m "$*"
}

bindkey \^U backward-kill-line

# ---- Docker Compose Helpers ----

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

# ---- dc mega command ----

function dc() {
  # Prompt for the command
  command=$(printf "logs -f --tail 100\nup --force-recreate -d\nbuild\nbuild --no-cache\nup -d\n" | fzf --prompt="Command: ")

  # Exit if no command was selected
  if [ -z "$command" ]; then
    exit 0
  fi

  # Prompt for the services
  services=$(printf "all\n$(docker compose ps --services)" | fzf --prompt="Services: " --multi)

  # Exit if no services were selected
  if [ -z "$services" ]; then
    exit 0
  fi

  # Handle "all" selection
  if [ "$services" = "all" ]; then
    services=""
  fi

  # Execute the command
  echo "Executing: $docker_compose $command $services"
  eval "$docker_compose $command $services" && dcl $services
}

# ---- NX Helpers ----
nx_run="npx nx run"

function _get_project() {
  local project=$1
  if [ -z "$project" ]; then
    project=$(npx nx show projects -p "apps/**" | fzf)
  fi
  echo $project
}

function pmr() {
  local project=$(_get_project $1)
  eval $nx_run $project:prisma:migrate:reset --force --skip-nx-cache
}

function pd() {
  local project=$(_get_project $1)
  eval $nx_run $project:prisma:migrate:deploy --force --skip-nx-cache
}

function pgt() {
  local project=$(_get_project $1)
  eval $nx_run $project:prisma:generate-types --skip-nx-cache
}

function pmd() {
  local project=$(_get_project $1)
  cd apps/$project
  eval npx prisma migrate dev
}

function ps() {
  local project=$(_get_project $1)
  cd apps/$project
  npx prisma studio
}

# ---- tanstack router ----
function tsrg() {
  local app=$1
  if [ -z "$app" ]; then
    echo "Error: No app provided."
    return 1
  fi
  cd apps/$app
  npx tsr generate
  cd -
}

# ---- github repos ----
function ghr() {
  local user=$1
  local REPO_NAME=$(gh repo list $user --limit 999 --json nameWithOwner --template '{{range .}}{{.nameWithOwner}}{{"\n"}}{{end}}' | fzf --height 100%)
  echo https://github.com/$REPO_NAME
}
function cghr() {
  local user=$1
  local REPO_NAME=$(ghr $user)
  git clone $REPO_NAME
}

# ---- Yazi ----
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}