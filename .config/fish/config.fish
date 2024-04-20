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
export FZF_DEFAULT_OPTS='--height 50% --layout=reverse --border'

# aliases
alias nv='nvim'
alias vim='nvim'
alias ls='eza -1 --icons -s ext --group-directories-first'
alias la='ls --all'
alias lt='eza --git-ignore -T --icons -s ext --group-directories-first'
alias cat='bat'
alias gorun='npx nodemon -q -e go --signal SIGTERM --exec go run .'
alias rustrun='cargo watch -c -d 0 -x run'
alias python='python3'
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias cpr='gh pr create --fill-first | pbcopy'
alias fzf_projects='find ~/Desktop ~/Desktop/work ~/Desktop/personal ~/.config -mindepth 1 -maxdepth 1 -type d | fzf'
alias p='cd $(fzf_projects || pwd)'
alias c='code $(fzf_projects) -r'
alias brewdump='cd ~ && brew bundle dump --casks --taps --brews --describe --force && cd -'

# start starfish
starship init fish | source
