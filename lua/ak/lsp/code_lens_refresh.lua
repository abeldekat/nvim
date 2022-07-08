local M = {}
local use_code_lens_refresh = true

-- Note: deleting a buffer deletes its autocommand in the group automatically
-- TODO: Is codeLensProvider correct?
function M.on_attach(client)
  if not (use_code_lens_refresh and client.server_capabilities.codeLensProvider) then
    return
  end

  local groupname = "ak_lsp_code_lens_refresh_" .. client.name

  -- autocmd! * buffer currently not possible in neovim api
  -- see:
  -- https://github.com/neovim/neovim/issues/17554
  vim.cmd("augroup " .. groupname)
  vim.cmd [[
      autocmd! * buffer
      autocmd InsertLeave <buffer> lua vim.lsp.codelens_refresh()
      autocmd InsertLeave <buffer> lua vim.lsp.codelens_display()
  ]]
  vim.cmd "augroup END"
end

return M
