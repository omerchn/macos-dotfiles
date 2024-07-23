function dcl --argument service
  docker compose logs $service -f --tail 100
end

complete --command dcl --no-files
for x in (docker compose ps --services)
    complete --command dcl --arguments $x
end
