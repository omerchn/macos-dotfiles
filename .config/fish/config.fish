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
    $PATH

# aliases
alias nv='nvim'
alias vim='nvim'
alias ls='exa -1 --icons -s ext --group-directories-first'
alias la='ls --all'
alias lt='exa --git-ignore -T --icons -s ext --group-directories-first'
alias cat='bat'
alias gorun='npx nodemon -e go --signal SIGTERM --exec go run .'
alias rustrun='cargo watch -c -d 0 -x run'
alias config='/usr/bin/git --git-dir=$HOME/.myconf/ --work-tree=$HOME'
alias cpr='gh pr create --fill-first | pbcopy'
alias python='python3'
alias pay_cqlsh='docker run -it --rm --entrypoint cqlsh scylladb/scylla -u scylla -p 08H3OSTxrjLbpVQ  34.251.235.224'
alias find_project='find ~/Desktop ~/Desktop/WORK ~/Desktop/PROJECTS ~/.config -mindepth 1 -maxdepth 1 -type d | fzf --reverse --info=right --no-scrollbar'
alias p='cd $(find_project)'
alias c='code $(find_project) -r'

# start starfish
starship init fish | source
