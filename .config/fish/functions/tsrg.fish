function tsrg --argument app
  if test -z "$app"
    echo "Error: No argument provided."
    return 1
  end
  cd apps/$app
  and npx tsr generate
  cd -
end