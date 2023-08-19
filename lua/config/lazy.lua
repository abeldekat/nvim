local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

local full_spec = {
  { "LazyVim/LazyVim", import = "lazyvim.plugins" },
  -- editor:
  { import = "lazyvim.plugins.extras.editor.mini-files" },
  -- ui:
  -- { import = "lazyvim.plugins.extras.ui.mini-starter" },
  -- { import = "lazyvim.plugins.extras.util.mini-hipatterns" },
  -- core:
  { import = "lazyvim.plugins.extras.test.core" },
  { import = "lazyvim.plugins.extras.dap.core" },
  -- lang:
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.lang.python" },
  { import = "lazyvim.plugins.extras.lang.python-semshi" },

  -- import/override with your plugins:
  { import = "plugins" },
  -- editor:
  { import = "plugins.extras.editor.mini-files" },
  -- core:
  { import = "plugins.extras.test.core" },
  -- lang:
  { import = "plugins.extras.lang.python" },
}

local dev_plugins = {} -- { "LazyVim", "lazy.nvim" } -- jit.os:find("Windows") and {}
local fallback = false -- default
require("lazy").setup({
  spec = full_spec,
  dev = { path = "~/projects/lazydev", patterns = dev_plugins, fallback = fallback },
  defaults = {
    lazy = false,
    version = false, -- always use the latest git commit, recommended for now
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = { enabled = false }, -- automatically check for plugin updates
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
