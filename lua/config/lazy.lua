---@diagnostic disable:assign-type-mismatch
-- { import = "lazyvim.plugins.extras.util.mini-hipatterns" },

local function bootstrap(lazypath)
  if not vim.loop.fs_stat(lazypath) then
    -- stylua: ignore
    vim.fn.system({
      "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      lazypath
    })
  end
  vim.opt.rtp:prepend(vim.env.LAZY or lazypath)
end
bootstrap(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")

return function(opts)
  local pde = opts.pde

  local plugins = {
    pde.lazyflex,
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    { import = "plugins" },
  }

  require("lazy").setup({
    spec = plugins,
    dev = { path = pde.dev_path, patterns = pde.dev_plugins },
    defaults = {
      lazy = false,
      version = false, -- "*", -- try installing the latest stable version
    },
    install = { colorscheme = { "tokyonight", "habamax" } }, -- try during install
    checker = { enabled = false }, -- check for plugin updates
    change_detection = { enabled = false }, -- reload ui on config file changes
    performance = {
      -- "matchit", "matchparen",
      rtp = {
        disabled_plugins = { "gzip", "netrwPlugin", "tarPlugin", "tohtml", "tutor", "zipPlugin" },
      },
    },
    debug = opts.debug,
  })
end
