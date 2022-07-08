--[[ Note: rose-pine is really fast. Compared to gruvbuddy, -15ms --]]
-- local commits = {
--   nightfox = "140136d7a5fe872ecbfe2a70bed3162e658a5c13",
-- }
local result = {
  {
    "lunarvim/darkplus.nvim",
    as = "color_darkplus",
    opt = true,
  },
  {
    "lunarvim/onedarker.nvim",
    as = "color_onedarker",
    opt = true,
  },
  { -- defines 5 colorschemes, 2 light
    "EdenEast/nightfox.nvim",
    as = "color_nightfox",
    opt = true,
    -- commit = commits.nightfox,
  },
  { -- one colorscheme multiple styles. Default set to warmer.
    "navarasu/onedark.nvim",
    as = "color_onedark",
    opt = true,
  },
  { -- one colorscheme three styles. Dawn is light
    "rose-pine/neovim",
    as = "color_rose-pine",
    opt = true,
  },
  { -- day, storm, dark. Doubled the config
    "folke/tokyonight.nvim",
    as = "color_tokyonight",
    opt = true,
  },
  {
    "catppuccin/nvim",
    as = "color_catppuccin",
    opt = true,
  },
  { -- no recent nvim plugins support, excellent colors. Switch with telescope
    "lifepillar/vim-solarized8",
    as = "color_solarized8",
    opt = true,
  },
  {
    "Mofiqul/dracula.nvim",
    as = "color_dracula",
    opt = true,
  },
  {
    "ellisonleao/gruvbox.nvim",
    as = "color_gruvbox",
    requires = { "rktjmp/lush.nvim" },
    opt = true,
  },
  {
    "luisiacc/gruvbox-baby",
    as = "color_gruvbox-baby",
    opt = true,
  },
  {
    "sainnhe/sonokai",
    as = "color_sonokai",
    opt = true,
  },
  {
    "sainnhe/everforest",
    as = "color_everforest",
    opt = true,
  },
  { --mixture between tokyonight and gruvbox
    "rebelot/kanagawa.nvim",
    as = "color_kanagawa",
    opt = true,
  },
  {
    "marko-cerovac/material.nvim",
    as = "color_material",
    opt = true,
  },
  {
    "sainnhe/edge",
    as = "color_edge",
    opt = true,
  },
  {
    "NTBBloodbath/doom-one.nvim",
    as = "color_doom-one",
    opt = true,
  },
  {
    "projekt0n/github-nvim-theme",
    as = "color_github-theme",
    opt = true,
  },
  {
    "daschw/leaf.nvim",
    as = "color_leaf.nvim",
    opt = true,
  },
  {
    "Mofiqul/vscode.nvim",
    as = "color_vscode.nvim",
    opt = true,
  },
  {
    "Mofiqul/adwaita.nvim",
    as = "color_adwaita.nvim",
    opt = true,
  },
  {
    "tjdevries/gruvbuddy.nvim",
    as = "color_gruvbuddy.nvim",
    opt = true,
    requires = {
      "tjdevries/colorbuddy.nvim",
      opt = true,
    },
  },
}
return result
