local filepath = vim.fn.fnamemodify(".lazy.lua", ":p")
local file = vim.secure.read(filepath)
if not file then
  return {}
end
return loadstring(file)()
