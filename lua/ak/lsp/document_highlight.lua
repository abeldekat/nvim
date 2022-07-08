local M = {}
local use_document_highlight = true
local groupname = "ak_lsp_document_highlight"
local augroup = vim.api.nvim_create_augroup(groupname, {})

-- Note: deleting a buffer deletes its autocommand in the group automatically

function M.on_attach(client, bufnr)
  if not (use_document_highlight and client.server_capabilities.documentHighlightProvider) then
    return
  end

  vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
  vim.api.nvim_create_autocmd("CursorHold", {
    group = augroup,
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.document_highlight()
    end,
  })
  vim.api.nvim_create_autocmd("CursorMoved", {
    group = augroup,
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.clear_references()
    end,
  })
end

return M
