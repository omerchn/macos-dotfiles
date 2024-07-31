function dcrl --argument service
  dcr $service
  dcl $service
end

complete --command dcrl --no-files
for x in (docker compose ps --services)
  complete --command dcrl --arguments $x
end