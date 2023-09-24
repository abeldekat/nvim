--[[
problems on redraw. Bug in upstream neovim
https://github.com/nvim-lualine/lualine.nvim/issues/825
https://github.com/nvim-lualine/lualine.nvim/issues/773
--]]

local override_event = function()
  return {}
end

return {
  {
    "goolord/alpha-nvim",
    cond = false,
  },

  {
    "LazyVim/LazyVim",
    init = function()
      -- override lazyvim.config.options, the I empties the startscreen:
      vim.opt.shortmess:append({ W = true, I = false, c = true })

      -- HACK: load keymaps on UIEnter instead of VeryLazy
      -- can have side effects related to key overriding
      -- for plugins loaded on VeryLazy!
      --
      -- scheduled in lazyvim.config.init, the setup method:
      -- keymaps are loaded last in the chain of VeryLazy events.
      -- see:
      -- https://github.com/folke/lazy.nvim/issues/1038
      -- bug: VeryLazy event affects the display welcome message
      vim.api.nvim_create_autocmd("UIEnter", {
        once = true,
        callback = function()
          -- problematic: lazyvim.config.keymaps L116
          -- if vim.lsp.inlay_hint then
          require("lazyvim.config").load("keymaps")
        end,
      })
    end,
    opts = {
      defaults = {
        autocmds = true, -- lazyvim.config.autocmds
        keymaps = true, -- lazyvim.config.keymaps
        -- lazyvim.config.options can't be configured here since that's loaded before lazyvim setup
        -- if you want to disable loading options,
        -- add `package.loaded["lazyvim.config.options"] = true` to the top of your init.lua
      },
    },
  },

  -- loaded by key
  -- { -- do not lazyload
  --   "folke/which-key.nvim",
  --   lazy = false,
  --   event = override_event
  -- },

  -- has the opts.options.section_separators = ""
  { -- do not lazyload
    -- and don't use default section operators!
    "nvim-lualine/lualine.nvim",
    lazy = false,
    event = override_event,
  },

  -- is disabled
  -- {
  --   "akinsho/bufferline.nvim",
  --   lazy = false,
  --   event = override_event,
  -- },

  -- is disabled
  -- {
  --   "folke/noice.nvim",
  --   lazy = false,
  --   event = override_event,
  -- },

  -- added
  {
    "echasnovski/mini.operators",
    lazy = false,
    event = override_event,
  },

  -- added
  {
    "jinh0/eyeliner.nvim",
    lazy = false,
    event = override_event,
  },
}
