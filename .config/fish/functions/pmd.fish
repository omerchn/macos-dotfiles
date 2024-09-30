function pmr --argument project
  npx nx run $project:prisma:migrate:dev --force --skip-nx-cache
end

complete --command pmr --no-files
for x in (npx nx show projects)
  complete --command pmr --arguments $x
end