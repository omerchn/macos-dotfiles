function ps --argument project
  cd apps/$project
  npx prisma studio
end

complete --command ps --no-files
for x in (npx nx show projects)
  complete --command ps --arguments $x
end