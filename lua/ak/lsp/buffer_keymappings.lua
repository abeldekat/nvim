--[[ctrl-o (jumplist), ctrl-t(taglist, lsp)--]]
local M = {}

-- KEY: LSP buffer. Also see diagnostics
-- also see telescope, lsp init
-- TODO: range formatting?
function M.on_attach(bufnr)
  -- -- Enable completion triggered by <c-x><c-o>
  -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local setter = vim.keymap.set
  local add = function(key, fun, desc)
    setter("n", key, fun, { desc = desc, buffer = bufnr, silent = true })
  end

  -- Note: this overwrites some default g keys
  add("gd", vim.lsp.buf.definition, "LSP Goto Definition")
  add("gD", vim.lsp.buf.declaration, "LSP Goto Declaration")
  add("K", vim.lsp.buf.hover, "LSP Show hover")
  add("gI", vim.lsp.buf.implementation, "LSP Goto Implementation")

  -- suggested mapping <ctrl-k>, in use for window navigation:
  -- leap, cross window changed is gs:
  add("gs", vim.lsp.buf.signature_help, "LSP Show signature help")

  -- suggested mapping: <space>w menu: allready in use for write:
  -- suggested mapping:<space>wa
  add("<leader>lA", vim.lsp.buf.add_workspace_folder, "LSP add workspace folder")
  -- suggested mapping:<space>wr
  add("<leader>lR", vim.lsp.buf.remove_workspace_folder, "LSP remove workspace folder")
  -- suggested mapping:<space>wl
  add("<leader>lL", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "LSP list workspace folders")
  -- suggested mapping:<space>D
  add("<leader>lD", vim.lsp.buf.type_definition, "LSP buf type definition")

  -- suggested mapping: <space>rn:
  add("gR", vim.lsp.buf.rename, "LSP Rename")
  -- suggested mapping: <space>ca:
  add("<leader>la", vim.lsp.buf.code_action, "LSP code action")
  add("gr", vim.lsp.buf.references, "LSP Goto References")

  -- not mentioned in suggested configuration
  -- used to be a global mapping
  add("<leader>lr", vim.lsp.codelens.run, "LSP CodeLens Action")
end

return M
