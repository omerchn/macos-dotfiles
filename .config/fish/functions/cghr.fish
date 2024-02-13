function cghr --argument user
    git clone https://github.com/$(ghr $user)
end
