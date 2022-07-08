-- No lazy loading, offers no benefits, sometimes even results in worse performance
local result = {

  -- used by lir, telescope, lualine.
  { "kyazdani42/nvim-web-devicons" },

  { "ahmedkhalf/project.nvim" },

  { "rafamadriz/friendly-snippets" },
  -- requires rafamadriz/friendly-snippets:
  { "L3MON4D3/LuaSnip" },

  { "tamago324/lir.nvim" },
  { "tamago324/lir-git-status.nvim" },

  { "ggandor/leap.nvim" },

  { "ThePrimeagen/harpoon" },

  -- navigate between splits and tmux panes
  { "numToStr/Navigator.nvim" },

  { "lewis6991/gitsigns.nvim" },

  { "numToStr/Comment.nvim" },
}
return result
