if vim.loader then
  vim.loader.enable()
end

if vim.loop.fs_stat(".nvim.lua") then
  vim.opt.exrc = true -- allow local .nvim.lua .vimrc .exrc files
else
  require("config.lazy")()
end
