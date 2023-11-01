local function push(list, ...)
  for i = 1, select('#', ...) do
    list[#list + 1] = select(i, ...)
  end
end

return {
  push = push
}
