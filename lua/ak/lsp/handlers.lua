local document_highlight = require "ak.lsp.document_highlight"
local buffer_keymappings = require "ak.lsp.buffer_keymappings"
local formatting = require "ak.lsp.formatting"
local diagnostics = require "ak.diagnostics"
-- local code_lens_refresh = require "ak.lsp.code_lens_refresh"

local float = {
  focusable = true,
  style = "minimal",
  border = "rounded",
}

local M = {}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, float)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, float)

function M.capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  }

  local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if status_ok then
    capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
  end

  return capabilities
end

function M.on_attach_formatting_opt_in(client, bufnr)
  return formatting.on_attach_opt_in(client, bufnr)
end

function M.on_attach_formatting_opt_out(client, bufnr)
  return formatting.on_attach_opt_out(client, bufnr)
end

function M.on_attach(client, bufnr)
  buffer_keymappings.on_attach(bufnr)
  diagnostics.on_attach(bufnr)
  document_highlight.on_attach(client, bufnr)

  -- disabled for the moment:
  -- code_lens_refresh.on_attach(client)
end

return M
