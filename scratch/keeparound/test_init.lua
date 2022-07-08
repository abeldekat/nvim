--[[
For testing the new nvim-lsp-installer api
--]]

vim.cmd [[ packadd nvim-lsp-installer ]]
require("nvim-lsp-installer").setup {}
require("lspconfig").jsonls.setup {}
require("lspconfig").bashls.setup {}
