function ghr --argument user
    gh repo list $user --limit 999 --json nameWithOwner --template '{{range .}}{{.nameWithOwner}}{{"\n"}}{{end}}' | fzf
end
