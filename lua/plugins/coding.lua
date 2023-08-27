return {
  -- ---------------------------------------------
  -- observing ....
  -- ---------------------------------------------
  -- NOTE: mini.ai:
  -- vib, viq, vi?. Mini does not override capital B
  -- incremental, g[
  -- in insertmode, press C-v, now the character will not be interpreted by ai
  -- lazyvim config: vio(treesitter block). Also overrides mini f with treesiter f

  -- ---------------------------------------------
  -- disabling ....
  -- ---------------------------------------------

  -- ---------------------------------------------
  -- overriding ....
  -- ---------------------------------------------
  {
    "echasnovski/mini.surround",
    event = function()
      return { "BufReadPost", "BufNewFile" } -- "VeryLazy"
    end,
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
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      -- g= evaluate
      -- gx exchange (overrides netrw mapping)
      -- gm multiply (overrides half a screen width to the right)
      -- gr replace with register (conflicts with lsp gr)
      -- gs sort (overrides go sleep)

      replace = { prefix = "cr" }, -- gr is taken...
    },
  },
}
