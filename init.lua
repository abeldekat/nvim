local lazyflex = {
  "abeldekat/lazyflex.nvim",
  cond = true,
  version = "*",
  import = "lazyflex.hook",
  opts = function()
    -- local config = { enabled = { true } }
    -- local presets = { "coding" }
    -- local l = { config = config, presets = presets } -- lazyvim
    -- local u = { config = config, presets = presets } --user
    -- local a = { "lazy", require("misc.colorscheme").color } -- kw_always_enable
    -- local kw = {}
    -- local e = true -- enable_match
    -- return { enable_match = e, lazyvim = l, user = u, kw_always_enable = a, kw = kw }
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
