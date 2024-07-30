function dcr --argument service
  docker compose restart $service
end

complete --command dcr --no-files
for x in (docker compose ps --services)
    complete --command dcr --arguments $x
end

