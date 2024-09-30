function dcu --argument service
  docker compose up $service -d
end

complete --command dcu --no-files
for x in (docker compose ps --services)
  complete --command dcu --arguments $x
end
