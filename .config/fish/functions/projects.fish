function projects --argument dir
  if not test -n "$dir"
    set dir ""
  end
  cd ~/Desktop/PROJECTS/$dir
end

complete --command projects --no-files
for x in ~/Desktop/PROJECTS/*/
    complete --command projects --arguments (basename $x)
end
