function fish_title
    set proc (status current-command)

    # if [ $proc = "fish" ]
    #     set proc ""
    # else
    #     set proc ": $proc"
    # end

    echo (fish_prompt_pwd_dir_length=1 prompt_pwd): $proc
end
