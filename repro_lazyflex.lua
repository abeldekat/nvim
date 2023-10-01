-- Minimal `init.lua` to reproduce an issue. Save as `repro.lua` and run with `nvim -u repro.lua`

-- bootstrap lazy.nvim:
local function bootstrap(root) -- sets std paths and installs lazy
  for _, name in ipairs({ "config", "data", "state", "cache" }) do
    vim.env[("XDG_%s_HOME"):format(name:upper())] = root .. "/" .. name
  end
  local lazypath = root .. "/plugins/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath })
  end
  vim.opt.rtp:prepend(lazypath)
end
local root = vim.fn.fnamemodify("./.repro", ":p")
bootstrap(root)

-- enable/disable multiple plugins:
local use_flex = true -- activate the plugin
local plugin_flex = not use_flex and {}
  or {
    "abeldekat/lazyflex.nvim",
    import = "lazyflex.plugins.intercept",
    -- defaulting to only LazyVim, lazy.nvim and tokyonight:
    opts = {},
    -- same as a minimal lazy.nvim, but LazyVim's plugin specs can be added:
    -- opts = { config = { enabled = false } },
  }

-- install plugins:
local plugins = {
  plugin_flex,
  "folke/tokyonight.nvim",
  { "LazyVim/LazyVim", import = "lazyvim.plugins" },
  -- add any other plugins here
}
require("lazy").setup(plugins, {
  root = root .. "/plugins",
})
-- add anything else here
