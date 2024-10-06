function gen_commit
    # Generate commit message
    set commit_msg (git diff | gen_commit_msg)

    # Display the generated commit message
    echo "Generated commit message:"
    echo "$commit_msg"


    if read_confirm
        git commit -am "$commit_msg"
        echo "Commit created with the message: $commit_msg"
    end
    echo "Commit aborted."
end