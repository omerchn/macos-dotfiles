function work --argument dir
  if not test -n "$dir"
    set dir ""
  end
  cd ~/Desktop/WORK/$dir
end

complete --command work --no-files
for x in ~/Desktop/WORK/*/
    complete --command work --arguments (basename $x)
end
