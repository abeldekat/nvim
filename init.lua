local lazyflex = {
  "abeldekat/lazyflex.nvim",
  cond = true,
  version = "*",
  import = "lazyflex.entry.lazyvim",
  opts = function()
    local em = true -- enable_match
    local settings = { enabled = true }
    local presets = { "editor" }
    local kw = {}
    local l = { settings = settings, presets = presets } -- lazyvim
    local u = { settings = settings, presets = presets } --user
    local a = { require("misc.colorscheme").color } -- kw_always_enable
    -- return { enable_match = em, lazyvim = l, user = u, kw_always_enable = a, kw = kw }
    return {}
  end,
}

require("config.lazy")({
  debug = false,
  pde = { -- centralizing custom settings
    -- dap_support = false,
    -- dev_plugins = { "lazyflex" },
    dev_plugins = {},
    lang = {
      json = true,
      -- python = true,
      yaml = true,
    },
    lazyflex = lazyflex,
    -- test_support = true,
  },
})
