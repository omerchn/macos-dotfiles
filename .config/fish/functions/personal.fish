function personal --argument dir
  if not test -n "$dir"
    set dir ""
  end
  cd ~/Desktop/personal/$dir
end

complete --command personal --no-files
for x in ~/Desktop/personal/*/
    complete --command personal --arguments (basename $x)
end
