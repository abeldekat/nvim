---@diagnostic disable:assign-type-mismatch
local function clone(owner, name)
  local url = string.format("%s/%s/%s.git", "https://github.com", owner, name)
  local path = vim.fn.stdpath("data") .. "/lazy/" .. name
  if not vim.loop.fs_stat(path) then
    vim.fn.system({ "git", "clone", "--filter=blob:none", url, "--branch=stable", path })
  end
  return path
end

return function(opts)
  local lazypath = clone("folke", "lazy.nvim")
  vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

  local plugins = {
    opts.flex and opts.flex or {},
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    { import = "plugins" },
  }

  require("lazy").setup({
    defaults = { lazy = false, version = false }, -- "*" = latest stable version
    spec = plugins,
    dev = { path = opts.dev_path, patterns = opts.dev_patterns },
    install = { colorscheme = { "tokyonight", "habamax" } },
    checker = { enabled = false },
    change_detection = { enabled = false },
    performance = {
      rtp = { -- "matchit", "matchparen",
        disabled_plugins = {
          "gzip",
          "netrwPlugin",
          "tarPlugin",
          "tohtml",
          "tutor",
          "zipPlugin",
        },
        paths = opts.flex and opts.clone_flex and { clone("abeldekat", "lazyflex.nvim") } or {},
      },
    },
    debug = opts.debug,
  })
end
