return {

  {
    "lukas-reineke/headlines.nvim",
    opts = function(_, opts)
      opts.markdown = {
        -- https://github.com/lukas-reineke/headlines.nvim/issues/41#issuecomment-1556334775
        fat_headline_lower_string = "▔",
      }
      return opts
    end,
  },

  {
    "ellisonleao/glow.nvim",
    cmd = "Glow",
    keys = {
      { "<leader>mg", "<cmd>Glow<cr>", desc = "Markdown [G]low" },
    },
    opts = {
      width_ratio = 0.8, --0.7
      height_ratio = 0.8, --0.7
    },
  },

  -- TODO: Test
  -- {
  --   "toppair/peek.nvim",
  --   build = "deno task --quiet build:fast",
  --   keys = {
  --     {
  --       "<leader>pp",
  --       function()
  --         local peek = require("peek")
  --         if peek.is_open() then
  --           peek.close()
  --         else
  --           peek.open()
  --         end
  --       end,
  --       desc = "Peek (Markdown Preview)",
  --       ft = "markdown",
  --     },
  --   },
  --   opts = { theme = "dark" },
  -- },
}
