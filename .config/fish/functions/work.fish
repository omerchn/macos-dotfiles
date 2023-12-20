function work
  cd ~/Desktop/WORK/$argv
end

complete --command work --no-files
for x in ~/Desktop/WORK/*/
    complete --command work --arguments (basename $x)
end