---@diagnostic disable:assign-type-mismatch
local function bootstrap(lazypath)
  if not vim.loop.fs_stat(lazypath) then
    -- stylua: ignore
    vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
  end
  vim.opt.rtp:prepend(vim.env.LAZY or lazypath)
end
bootstrap(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")

-- local dev_plugins = { "lazyflex" }
local dev_plugins = {}
local cond_flex = false
local import_flex = cond_flex and "lazyflex.plugins.intercept" or "lazyflex.plugins.noop"

local plugins = { -- approach: grouping extra and override
  {
    "abeldekat/lazyflex.nvim",
    cond = cond_flex,
    import = import_flex,
    opts = {
      -- user = { presets = { "test" } },
      -- keywords = { "dark" },
    },
  },
  { "LazyVim/LazyVim", import = "lazyvim.plugins" },

  --> extras
  --> util: { import = "lazyvim.plugins.extras.util.mini-hipatterns" },
  { import = "lazyvim.plugins.extras.util.project" },
  { import = "plugins.extras.util.project_override" },
  --> test:
  { import = "lazyvim.plugins.extras.test.core" },
  { import = "plugins.extras.test.core_override" },
  --> dap: { import = "lazyvim.plugins.extras.dap.core" },
  --> lang, json and yaml:
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.lang.yaml" },
  --> lang, python:
  { import = "lazyvim.plugins.extras.lang.python" },
  { import = "lazyvim.plugins.extras.lang.python-semshi" },
  { import = "plugins.extras.lang.python_override" },

  --> plugins:
  { import = "plugins" },
  { import = "plugins.extras.colors.group_one" },
  -- { import = "plugins.extras.colors.group_two" },
  -- { import = "plugins.extras.colors.group_three" },
  -- { import = "plugins.extras.default_startscreen" },
}
require("lazy").setup({
  spec = plugins,
  dev = { path = "~/projects/lazydev", patterns = dev_plugins },
  defaults = {
    lazy = false,
    version = false, -- "*", -- try installing the latest stable version
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = { enabled = false }, -- check for plugin updates
  change_detection = { enabled = false }, -- reload ui on config file changes
  performance = {
    -- "matchit", "matchparen",
    rtp = { disabled_plugins = { "gzip", "netrwPlugin", "tarPlugin", "tohtml", "tutor", "zipPlugin" } },
  },
})
