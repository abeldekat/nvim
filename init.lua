local lazyflex = {
  "abeldekat/lazyflex.nvim",
  cond = true,
  version = "*",
  import = "lazyflex.hook",
  opts = function()
    -- local config = { enabled = { true } }
    -- local presets = { "coding" }
    -- local lazyvim = { config = config, presets = presets }
    -- local user = { config = config, presets = presets }
    -- local enable_match = true
    -- local kw = {}
    --
    -- if enable_match then
    --   table.insert(kw, require("misc.colorscheme").color)
    -- end
    -- return { enable_match = enable_match, lazyvim = lazyvim, user = user, kw = kw }
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
