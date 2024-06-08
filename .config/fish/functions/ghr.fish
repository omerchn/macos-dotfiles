function ghr --argument user
    set REPO_NAME (gh repo list $user --limit 999 --json nameWithOwner --template '{{range .}}{{.nameWithOwner}}{{"\n"}}{{end}}' | fzf --height 100%)
    echo https://github.com/$REPO_NAME
end
