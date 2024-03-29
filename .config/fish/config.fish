if status is-interactive
    # Commands to run in interactive sessions (keyboard connected) can go here
    # nvm use -s
end

# add to PATH
set PATH \
    $HOME/.cargo/bin \
    $HOME/google-cloud-sdk/bin \
    /opt/homebrew/bin \
    $HOME/.bun/bin \
    $GOPATH/bin \
    $PATH

# env vars
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

# aliases
alias nv='nvim'
alias vim='nvim'
alias ls='exa -1 --icons -s ext --group-directories-first'
alias la='ls --all'
alias lt='exa --git-ignore -T --icons -s ext --group-directories-first'
alias cat='bat'
alias gorun='npx nodemon -e go --signal SIGTERM --exec go run .'
alias rustrun='cargo watch -c -d 0 -x run'
alias python='python3'
alias config='git --git-dir=$HOME/.myconf/ --work-tree=$HOME'
alias cpr='gh pr create --fill-first | pbcopy'
alias fzf_projects='find ~/Desktop ~/Desktop/WORK ~/Desktop/PROJECTS ~/.config -mindepth 1 -maxdepth 1 -type d | fzf'
alias p='cd $(fzf_projects || pwd)'
alias c='code $(fzf_projects) -r'

# start starfish
starship init fish | source
