local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

local test_spec_separated = {
  { "LazyVim/LazyVim" },
  { import = "lazyvim.plugins.colorscheme" },
  { import = "lazyvim.plugins.coding" },
  { import = "lazyvim.plugins.core" },
  { import = "lazyvim.plugins.editor" },
  { import = "lazyvim.plugins.lsp" },
  { import = "lazyvim.plugins.treesitter" },
  { import = "lazyvim.plugins.ui" },
  { import = "lazyvim.plugins.util" },
}

local test_spec_default = {
  -- add LazyVim and import its plugins:
  { "LazyVim/LazyVim", import = "lazyvim.plugins" },
  -- { import = "lazyvim.plugins.extras.editor.leap" },
  { "akinsho/bufferline.nvim", enabled = false },
}

local full_spec = {
  -- add LazyVim and import its plugins:
  { "LazyVim/LazyVim", import = "lazyvim.plugins" },

  -- import any extras modules here:
  -- editor:
  -- { import = "lazyvim.plugins.extras.editor.leap" },
  { import = "lazyvim.plugins.extras.editor.mini-files" },
  -- ui:
  -- { import = "lazyvim.plugins.extras.util.mini-hipatterns" },
  -- core:
  { import = "lazyvim.plugins.extras.test.core" },
  -- { import = "lazyvim.plugins.extras.dap.core" },
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

require("lazy").setup({
  -- spec = test_spec_separated, -- some lsp errors?
  -- spec = test_spec_default,
  spec = full_spec,
  -- dev = { patterns = jit.os:find("Windows") and {} or { "abeldekat", "LazyVim", "lazy.nvim" } },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = { enabled = false }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
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
