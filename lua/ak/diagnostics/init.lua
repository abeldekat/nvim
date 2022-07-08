--[[
Nvim provides a framework for displaying errors or warnings from external
tools, otherwise known as "diagnostics". These diagnostics can come from a
variety of sources, such as linters or LSP servers. The diagnostic framework
is an extension to existing error handling functionality such as the
|quickfix| list.
--]]

local M = {}

local config = {
  signs = {
    active = true,
    values = {
      { name = "DiagnosticSignError", text = "" },
      { name = "DiagnosticSignWarn", text = "" },
      { name = "DiagnosticSignHint", text = "" },
      { name = "DiagnosticSignInfo", text = "" },
    },
  },
  virtual_text = false,
  update_in_insert = true, --false, neovim from scratch
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
    format = function(d)
      local t = vim.deepcopy(d)
      local code = d.code or (d.user_data and d.user_data.lsp.code)
      if code then
        t.message = string.format("%s [%s]", t.message, code):gsub("1. ", "")
      end
      return t.message
    end,
  },
}


-- KEY: Buffer scoped diagnostic keys. Also useful: umimpaired
-- see also: telescope diagnostics
-- Note: Even if the keys are global, functions can be scoped to the buffer
function M.on_attach(bufnr)
  local setter = vim.keymap.set
  local add = function(key, fun, desc)
    setter("n", key, fun, { desc = desc, buffer = bufnr, silent = true })
  end

  -- used to be <leader>ds
  add("gL", vim.diagnostic.setloclist, "Diagnostics Location List")

  -- used to be <leader>dl
  add("gl", vim.diagnostic.open_float, "Diagnostics show line")

  -- used to be <leader>dk
  -- even this is an overwrite, macro definition
  add("[d", vim.diagnostic.goto_prev, "Diagnostics show previous")
  -- used to be <leader>dj
  add("]d", vim.diagnostic.goto_next, "Diagnostics show next")
end

-- Configure diagnostic options globally or for a specific diagnostic namespace.
for _, sign in ipairs(config.signs.values) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
end

vim.diagnostic.config(config)

return M
