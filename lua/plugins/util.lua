return {
  -- ---------------------------------------------
  -- overriding ....
  -- ---------------------------------------------

  { -- session management, override q keys
    "folke/persistence.nvim",
    keys = function(_, _)
      return {
        {
          "<leader>ms",
          function()
            require("persistence").load()
          end,
          desc = "Restore [S]ession",
        },
        {
          "<leader>ml",
          function()
            require("persistence").load({ last = true })
          end,
          desc = "Restore [L]ast Session",
        },
        {
          "<leader>md",
          function()
            require("persistence").stop()
          end,
          desc = "[D]on't Save Current Session",
        },
      }
    end,
  },

  -- ---------------------------------------------
  -- adding ....
  -- also interesting:
  -- https://github.com/michaelb/sniprun, included in astro community
  -- https://github.com/toppair/peek.nvim/issues/47
  -- ---------------------------------------------

  {
    -- Find neovim terminal job id: echo &channel
    "jpalardy/vim-slime",
    keys = { { "<leader>mr", "", desc = "Load slime [R]epl, and use <c-c><c-c>" } },
    init = function()
      vim.g.slime_target = "neovim"
    end,
  },

  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    keys = {
      { "<leader>mm", "<cmd>MarkdownPreviewToggle<cr>", desc = "Toggle [M]arkdown Preview" },
    },
    build = "cd app && npm install && git reset --hard",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_browser = "firefox"
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

  -- {
  --   "lukas-reineke/headlines.nvim",
  --   ft = "markdown",
  --   dependencies = "nvim-treesitter/nvim-treesitter",
  --   config = true,
  -- },

  -- iron.nvim does not work consistently
  -- {
  --   "Vigemus/iron.nvim",
  --   enabled = true,
  --   keys = {
  --     { "<leader>or", "<cmd>IronRepl<cr>", desc = "Start repl" },
  --     -- { "<leader>or", "<cmd>IronRestart<cr>", "Restart repl" },
  --     { "<leader>of", "<cmd>IronFocus<cr>", desc = "Focus repl" },
  --     { "<leader>oh", "<cmd>IronHide<cr>", desc = "Hide repl" },
  --   },
  --   main = "iron.core",
  --   opts = function(_, _)
  --     return {
  --       config = {
  --         -- Whether a repl should be discarded or not
  --         scratch_repl = false,
  --         -- Your repl definitions come here
  --         repl_definition = {
  --           sh = {
  --             -- Can be a table or a function that
  --             -- returns a table (see below)
  --             command = { "zsh" },
  --           },
  --         },
  --         -- How the repl window will be displayed
  --         -- See below for more information
  --         repl_open_cmd = "vertical botright 80 split",
  --         -- repl_open_cmd = require("iron.view").bottom(40),
  --       },
  --       keymaps = {
  --         send_motion = "<space>sc",
  --         visual_send = "<space>sc",
  --         send_file = "<space>sf",
  --         send_line = "<space>sl",
  --         send_until_cursor = "<space>su",
  --         send_mark = "<space>sm",
  --         mark_motion = "<space>mc",
  --         mark_visual = "<space>mc",
  --         remove_mark = "<space>md",
  --         cr = "<space>s<cr>",
  --         interrupt = "<space>s<space>",
  --         exit = "<space>sq",
  --         clear = "<space>cl",
  --       },
  --       -- If the highlight is on, you can change how it looks
  --       -- For the available options, check nvim_set_hl
  --       highlight = {
  --         italic = true,
  --       },
  --       ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
  --     }
  --   end,
  -- },
}
