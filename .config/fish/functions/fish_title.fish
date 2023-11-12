function fish_title
    set proc (status current-command)
    echo (fish_prompt_pwd_dir_length=1 prompt_pwd): $proc
end
