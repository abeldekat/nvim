-- local dev_plugins = { "lazyflex" }
local dev_plugins = {}

require("config.lazy")({
  debug = false,
  pde = { -- centralizing custom settings
    dap_support = false,
    dev_plugins = dev_plugins,
    lang = {
      json = true,
      python = true,
      yaml = true,
    },
    lazyflex = {
      "abeldekat/lazyflex.nvim",
      cond = true,
      import = "lazyflex.plugins.intercept",
      opts = {
        -- lazyvim = { presets = { "ui" } },
        -- user = { presets = { "test" } },
        -- keywords = { require("misc.colorscheme").color },
      },
    },
    test_support = true,
  },
})
