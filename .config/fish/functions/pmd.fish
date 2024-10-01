function pmd --argument project
  if test -z "$project"
    echo "Error: No project provided."
    return 1
  end
  cd apps/$project
  and npx prisma migrate dev
  cd -
end

complete --command pmd --no-files
for x in (npx nx show projects)
  complete --command pmd --arguments $x
end