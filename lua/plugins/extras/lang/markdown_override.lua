return {

  {
    "lukas-reineke/headlines.nvim",
    enabled = true, -- sometimes flickers...
    opts = function(_, opts)
      opts.markdown = {
        -- https://github.com/lukas-reineke/headlines.nvim/issues/41#issuecomment-1556334775
        fat_headline_lower_string = "▔",
      }
      return opts
    end,
  },

  { -- 20231102: https://github.com/toppair/peek.nvim/issues/47
    "saimo/peek.nvim", -- toppair/peek.nvim
    -- enabled = function()
    --   if vim.fn.executable("deno") == 1 then
    --     return true
    --   end
    --   require("lazyvim.util").warn({
    --     "`peek.nvim` requires `deno` to be installed.\n",
    --     "To hide this message, install `deno` or disable the `toppair/peek.nvim` plugin.",
    --   }, { title = "LazyVim Extras `lang.markdown`" })
    --   return false
    -- end,
    build = "deno task --quiet build:fast",
    keys = {
      {
        "<leader>ck",
        ft = "markdown",
        function()
          local peek = require("peek")
          if peek.is_open() then
            peek.close()
          else
            peek.open()
          end
        end,
        desc = "Pee[k] (Markdown Preview)",
      },
    },
    opts = { theme = "light" },
  },
}

-- {
--   "ellisonleao/glow.nvim",
--   cmd = "Glow",
--   keys = {
--     { "<leader>mg", "<cmd>Glow<cr>", desc = "Markdown [G]low" },
--   },
--   opts = {
--     width_ratio = 0.8, --0.7
--     height_ratio = 0.8, --0.7
--   },
-- },
