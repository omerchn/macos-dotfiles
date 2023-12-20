function projects
  cd ~/Desktop/PROJECTS/$argv
end

complete --command projects --no-files
for x in ~/Desktop/PROJECTS/*/
    complete --command projects --arguments (basename $x)
end