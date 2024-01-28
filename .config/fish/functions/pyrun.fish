function pyrun --argument file
    npx nodemon -e py --signal SIGTERM --exec python3 $file
end