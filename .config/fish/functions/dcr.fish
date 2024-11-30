function dcr --argument service
  # docker compose up $service --force-recreate -d && dcl $service
  docker compose -f docker-compose.yml -f docker-compose.debug.yml up $service --force-recreate -d && dcl $service
end

complete --command dcr --no-files
for x in (docker compose ps --services)
  complete --command dcr --arguments $x
end

