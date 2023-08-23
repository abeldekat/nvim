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
}
