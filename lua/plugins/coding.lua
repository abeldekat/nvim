return {
  -- ---------------------------------------------
  -- observing ....
  -- ---------------------------------------------
  -- NOTE: mini.ai: see treesitter.lua

  -- NOTE: mini.pairs
  -- in insertmode, press C-v, now the character will not be interpreted

  -- ---------------------------------------------
  -- disabling ....
  -- ---------------------------------------------

  -- ---------------------------------------------
  -- overriding ....
  -- ---------------------------------------------
  {
    "echasnovski/mini.surround", -- lazyloaded by keys
    opts = {
      mappings = {
        add = "<leader>za", -- Add surrounding in Normal and Visual modes
        delete = "<leader>zd", -- Delete surrounding
        find = "<leader>zf", -- Find surrounding (to the right)
        find_left = "<leader>zF", -- Find surrounding (to the left)
        highlight = "<leader>zh", -- Highlight surrounding
        replace = "<leader>zr", -- Replace surrounding
        update_n_lines = "<leader>zn", -- Update `n_lines`
      },
    },
  },

  -- ---------------------------------------------
  -- adding ....
  -- ---------------------------------------------
  {
    "echasnovski/mini.operators",
    event = "VeryLazy",
    -- keys = {
    --   { "cr", desc = "Replace", mode = { "n", "v" } },
    --   { "g=", desc = "Evaluate", mode = { "n", "v" } },
    --   { "gm", desc = "Multiply", mode = { "n", "v" } }, -- overrides half a screen width to the right
    --   { "gs", desc = "Sort", mode = { "n", "v" } }, -- overrides go sleep
    --   { "gx", desc = "Exchange", mode = { "n", "v" } }, -- overrides netrw mapping
    -- },
    opts = {
      replace = { prefix = "cr" }, -- lsp: gr is taken...
    },
  },
}
