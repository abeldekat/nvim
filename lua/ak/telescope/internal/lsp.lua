local mapper = require "ak.telescope.mapper"

--KEY: Telescope Lsp

local function document_symbols()
  local opts = require("telescope.themes").get_ivy {}
  require("telescope.builtin").lsp_document_symbols(opts)
end
mapper.map("<leader>ls", document_symbols, "Telescope Lsp Document Symbols")

local function dynamic_workspace_symbols()
  local opts = require("telescope.themes").get_ivy {}
  require("telescope.builtin").lsp_dynamic_workspace_symbols(opts)
end
mapper.map("<leader>lS", dynamic_workspace_symbols, "Telescope Lsp Dynamic Workspace Symbols")
