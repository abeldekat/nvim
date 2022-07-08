local disable = {
  toggleterm = false,
  fidget = false, -- works great
}
local result = {

  require "pa.dap",

  { "tpope/vim-repeat" },
  { "tpope/vim-surround" },
  { "tpope/vim-scriptease", cmd = { "Messages", "Scriptnames" } },
  { "nvim-lualine/lualine.nvim" },

  -- not lazy, telescope sometimes unexpected retains insert mode after choosing
  { "lukas-reineke/indent-blankline.nvim" },

  {
    "akinsho/toggleterm.nvim",
    keys = { "<space>gg", "<c-\\>" },
    config = function()
      require "ak.lazy_config.terminal"
    end,
    disable = disable.toggleterm,
  },

  { -- activate when needed, show colors by color code
    "norcalli/nvim-colorizer.lua",
    cmd = "ColorizerToggle",
    config = function()
      require "ak.lazy_config.colorizer"
    end,
  },

  {
    "folke/trouble.nvim",
    keys = { "<leader>dt" },
    cmd = "TroubleToggle",
    config = function()
      require "ak.lazy_config.trouble"
    end,
  },

  {
    "folke/zen-mode.nvim",
    keys = { "<leader>mz" },
    config = function()
      require "ak.lazy_config.zen"
    end,
  },

  {
    "folke/twilight.nvim",
    cmd = { "Twilight" },
    module = "twilight",
    config = function()
      require "ak.lazy_config.twilight"
    end,
  },

  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTelescope", "TodoTrouble", "TodoLocList", "TodoQuickFix" },
    config = function()
      require "ak.lazy_config.todo_comments"
    end,
  },

  { -- peeks lines of the buffer in non-obtrusive way
    "nacro90/numb.nvim",
    event = "CmdlineChanged",
    config = function()
      require "ak.lazy_config.numb"
    end,
  },

  {
    "lervag/vimtex",
    ft = "tex",
    config = function()
      require "ak.lazy_config.vimtex"
    end,
  },

  {
    "sindrets/diffview.nvim",
    cmd = "DiffviewOpen",
  },

  -- UIEnter, after VimEnter, a UI or TUI connects
  -- vim.lsp.handlers["$/progress"] = handle_progress
  { -- lsp startup spinner, adds roughly 10 ms to startup if not lazy
    "j-hui/fidget.nvim",
    event = "UIEnter",
    config = function()
      require "ak.lazy_config.fidget"
    end,
    disable = disable.fidget,
  },

  -- {
  --   "nfnty/vim-nftables",
  -- },
}
return result
