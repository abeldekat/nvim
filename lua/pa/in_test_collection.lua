-- TODO:
-- git-worktree, primagen, maybe  plasticboy / vim-markdown
-- use {
-- 	'f3fora/nvim-texlabconfig',
-- 	config = [[require('texlabconfig').setup()]],
-- }
local disable = {
  unimpaired = true,
}
-- These events from nth collection can be improved
local result = {
  {
    "tpope/vim-unimpaired",
    event = "CursorHold",
    disable = disable.unimpaired,
  },

  {
    "tjdevries/train.nvim",
    opt = true,
    -- config = function()
    --   require "ak.lazy_config.train"
    -- end,
  },

  {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_browser = "firefox"
    end,
    ft = "markdown",
  },
}
return result

-- good plugin, no lazy loading necessary. However, not needed
-- and: overrides a lot of inbuilt motions
-- { -- smooth scrolling with for example c-u
--   "karb94/neoscroll.nvim",
--   event = "BufHidden",
--   config = function()
--     require "ak.lazy_config.neoscroll"
--   end,
-- },

-- { --  no lazyloading
--   "ggandor/lightspeed.nvim", config = function() require "ak.lazy_config.lightspeed" end,
-- },
-- {
--   "windwp/nvim-autopairs",
--   -- lunarvim: no event
--   -- event = "CursorHold",
--   event = "InsertEnter *",
--   config = function()
--     require "ak.lazy_config.autopairs"
--   end,
--   after = "nvim-cmp",
--   disable = disable.autopairs,
-- },
-- { -- better git commit from terminal, uses autocmd on BufReadPost
--   "rhysd/committia.vim",
--   event = "BufReadPre",
--   disable = disable.committia,
-- },

-- { "Mephistophiles/surround.nvim", config = function() require "ak.lazy_config.surround" end, },
-- { "justinmk/vim-dirvish", config = function() require "ak.lazy_config.dirvish" end, },
-- Tried 3 possible tablines. Lualine fits the requirements
-- { "alvarosevilla95/luatab.nvim", },
-- { "crispgm/nvim-tabline", },
-- { "kdheepak/tabline.nvim", },

-- { -- TODO:
--   "tpope/vim-abolish",
--   event = "CursorHold",
-- },
-- { -- TODO: Extended increment/decrement plugin, see tpope speeddating
--   "monaqa/dial.nvim",
--   event = "BufRead",
--   config = function()
--     require "ak.lazy_config.dial"
--   end,
-- },
-- { -- TODO: The goal of nvm-bqf is to make Neovim's quickfix window better.
--   "kevinhwang91/nvim-bqf",
--   event = "BufRead",
-- },
-- { -- TODO: The interactive scratchpad for hackers.
--   "metakirby5/codi.vim",
--   cmd = "Codi",
-- },

-- tweakmonster, django-plus
-- django, coc:
-- https://github.com/rtts/djhtml
-- https://github.com/yaegassy/coc-htmldjango
-- simrat39/symbols-outline.nvim
--
-- Removed:
-- { "rcarriga/nvim-notify" },
-- { "Tastyep/structlog.nvim" },
