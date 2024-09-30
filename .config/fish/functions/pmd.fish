function pmd --argument project
  npx nx run $project:prisma:migrate:dev
end

complete --command pmd --no-files
for x in (npx nx show projects)
  complete --command pmd --arguments $x
end