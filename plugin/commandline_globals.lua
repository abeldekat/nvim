local reloader = require "ak.core.reloader"

P = function(v)
  print(vim.inspect(v))
  return v
end

R = function(name)
  reloader.reload(name)
  return require(name)
end
