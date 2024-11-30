function dcu --argument service
  docker compose -f docker-compose.yml -f docker-compose.debug.yml up $service -d
end

complete --command dcu --no-files
for x in (docker compose ps --services)
  complete --command dcu --arguments $x
end
