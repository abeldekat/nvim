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

  local plugins = { -- approach: grouping extra and override
    pde.lazyflex,
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },

    --> extras:
    -->  util:
    { import = "lazyvim.plugins.extras.util.project" },
    { import = "plugins.extras.util.project_override" },
    -->  test:
    { import = "lazyvim.plugins.extras.test.core", cond = pde.test_support },
    { import = "plugins.extras.test.core_override", cond = pde.test_support },
    -->  dap:
    { import = "lazyvim.plugins.extras.dap.core", enabled = pde.dap_support },
    -->  lang:
    { import = "lazyvim.plugins.extras.lang.json", cond = pde.lang.json },
    { import = "lazyvim.plugins.extras.lang.yaml", cond = pde.lang.yaml },
    { import = "lazyvim.plugins.extras.lang.python", cond = pde.lang.python },
    { import = "lazyvim.plugins.extras.lang.python-semshi", cond = pde.lang.python },
    { import = "plugins.extras.lang.python_override", cond = pde.lang.python },

    --> custom:
    { import = "plugins" },
    { import = "plugins.extras.colors.group_one" },
    -- { import = "plugins.extras.colors.group_two" },
    -- { import = "plugins.extras.colors.group_three" },
    -- { import = "plugins.extras.default_startscreen" },
  }

  require("lazy").setup({
    spec = plugins,
    dev = { path = "~/projects/lazydev", patterns = pde.dev_plugins },
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
