function dcb --argument service
  docker compose build $service
end

complete --command dcb --no-files
for x in (docker compose ps --services)
  complete --command dcb --arguments $x
end
