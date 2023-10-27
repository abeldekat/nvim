local lazyflex = {
  "abeldekat/lazyflex.nvim",
  cond = true,
  version = "*",
  import = "lazyflex.entry.lazyvim",
  opts = function()
    local pass_through = true

    if pass_through then
      return {}
    end

    local settings = { enabled = true }
    local presets = {}
    return {
      kw_always_enable = { require("misc.colorscheme").color },
      lazyvim = { settings = settings, presets = presets },
      user = { settings = settings, presets = presets },
      enable_match = true,
      kw = { "tokyo", "trees", "test", "pyth", "plen" },
      override_kw = { "context" },
    }
  end,
}

require("config.lazy")({
  debug = false,
  pde = { -- centralizing settings subject to change
    -- dev_path:
    -- dev_path = "~/projects/lazydev",
    -- dev_path = "~/projects/clone",
    dev_plugins = {},
    -- dev_plugins = { "LazyVim", "lazyflex" },
    lazyflex = lazyflex,
  },
})
