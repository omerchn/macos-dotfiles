function work --argument dir
  if not test -n "$dir"
    set dir ""
  end
  cd ~/Desktop/work/$dir
end

complete --command work --no-files
for x in ~/Desktop/work/*/
    complete --command work --arguments (basename $x)
end
