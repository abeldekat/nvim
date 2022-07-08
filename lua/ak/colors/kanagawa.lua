--[[
rebelot/kanagawa.nvim: mixture between tokyonight and gruvbox
NeoVim dark colorscheme inspired by the colors of the famous painting by Katsushika Hokusai.
--]]
require("ak.core.keytoggler").reset_keys()
vim.cmd [[packadd color_kanagawa]]
vim.cmd "colorscheme kanagawa"
