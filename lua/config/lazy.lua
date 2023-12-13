---@diagnostic disable:assign-type-mismatch
local function clone(owner, name)
  local url = string.format("%s/%s/%s.git", "https://github.com", owner, name)
  local path = vim.fn.stdpath("data") .. "/lazy/" .. name
  if not vim.loop.fs_stat(path) then
    vim.fn.system({ "git", "clone", "--filter=blob:none", url, "--branch=stable", path })
  end
  return path
end

return function(extraspec)
  local opts = require("config.defaults")
  local _ = opts.flex and { clone("abeldekat", "lazyflex.nvim") } or {}

  local lazypath = clone("folke", "lazy.nvim")
  vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

  local spec = {
    opts.flex and opts.flex or {},
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    { import = "plugins" },
    { import = "plugins.extras.lazyrc" },
  }

  require("lazy").setup({
    defaults = { lazy = false, version = false }, -- "*" = latest stable version
    spec = extraspec and vim.list_extend(spec, extraspec) or spec,
    dev = { path = opts.dev_path, patterns = opts.dev_patterns },
    install = { colorscheme = { "tokyonight", "habamax" } },
    checker = { enabled = false },
    change_detection = { enabled = false },
    performance = {
      rtp = { -- "matchit", "matchparen",
        disabled_plugins = { "gzip", "netrwPlugin", "tarPlugin", "tohtml", "tutor", "zipPlugin" },
      },
    },
    debug = opts.debug,
  })
end
