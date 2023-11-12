if status is-interactive
    # Commands to run in interactive sessions (keyboard connected) can go here
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
alias ls='exa -1 --icons -s ext --group-directories-first'
alias la='ls --all'
alias lt='exa --git-ignore -T --icons -s ext --group-directories-first'
alias cat='bat'
alias gorun='npx nodemon -e go --signal SIGTERM --exec go run .'
alias rustrun='cargo watch -c -d 0 -x run'
alias config='/usr/bin/git --git-dir=$HOME/.myconf/ --work-tree=$HOME'