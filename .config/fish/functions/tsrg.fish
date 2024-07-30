function tsrg --argument app
  if test -z "$app"
    echo "Error: No app provided."
    return 1
  end
  cd apps/$app
  and npx tsr generate
  cd -
end