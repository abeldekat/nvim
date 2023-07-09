-- https://github.com/folke/noice.nvim/wiki/Minimal-%60init.lua%60-to-Reproduce-an-Issue
-- To test the minimal config, save the file as minimal.lua and run nvim -u minimal.lua
local root = vim.fn.fnamemodify("./.repro", ":p")

-- set stdpaths to use .repro
for _, name in ipairs({ "config", "data", "state", "cache" }) do
  vim.env[("XDG_%s_HOME"):format(name:upper())] = root .. "/" .. name
end

-- bootstrap lazy
local lazypath = root .. "/plugins/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch", -- needed?
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

-- install plugins
local plugins = {
  "folke/tokyonight.nvim",
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },
}
require("lazy").setup(plugins, {
  root = root .. "/plugins",
})

vim.opt.termguicolors = true
vim.cmd.colorscheme("tokyonight")
-- add anything else here

require("noice").setup()
