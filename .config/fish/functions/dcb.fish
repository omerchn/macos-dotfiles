function dcb --argument service
  docker compose -f docker-compose.yml -f docker-compose.debug.yml build $service && dcr $service
end

complete --command dcb --no-files
for x in (docker compose ps --services)
  complete --command dcb --arguments $x
end
