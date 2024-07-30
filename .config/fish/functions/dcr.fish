function dcr --argument service
  docker-compose up $service --force-recreate -d
end

complete --command dcr --no-files
for x in (docker compose ps --services)
    complete --command dcr --arguments $x
end

