if status is-interactive
    # Commands to run in interactive sessions (keyboard connected) can go here
    # nvm use -s
end

# add to PATH
set PATH \
    $HOME/.cargo/bin \
    $HOME/google-cloud-sdk/bin \
    /opt/homebrew/bin \
    /opt/homebrew/opt/libpq/bin \
    $HOME/.bun/bin \
    $GOPATH/bin \
    $PATH

# env vars
export FZF_DEFAULT_OPTS='--height 90% --layout=reverse --border=none --no-separator --no-scrollbar --info=hidden' # --color=bg+:-1 to hide selected item bg
export FZF_CTRL_R_OPTS='--prompt="Command history> "'

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
alias _cpr='gh pr create --fill-first'
alias cpr='_cpr | pbcopy'
alias cprd='_cpr --draft | pbcopy'
alias fzf_projects='find ~/Desktop ~/Desktop/work ~/Desktop/personal ~/.config -mindepth 1 -maxdepth 1 -type d | fzf'
alias p='cd $(fzf_projects || pwd)'
alias c='code $(fzf_projects) -r'
alias brewdump='cd ~ && brew bundle dump --casks --taps --brews --force && cd -'
alias lg='lazygit'
alias ld='lazydocker'
alias ln='lazynpm'

# misc
alias gen_commit_msg='python3 ~/Desktop/personal/openai-commit-message-generator/openai-commit-message-generator.py'

# setup starfish
starship init fish | source

# setup zoxide
zoxide init fish | source

# source local fish functions
if test -d ./.fish/functions
    for x in ./.fish/functions/*
        source $x
    end
end
