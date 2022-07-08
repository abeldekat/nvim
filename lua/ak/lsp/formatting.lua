--[[
https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts

-- 'drop into client.request, as currently mentioned in the wiki of lspconfig'
-- vim.keymap.set('n', '<leader>lf', function()
--   local params = util.make_formatting_params({})
--   client.request('textDocument/formatting', params, nil, bufnr)
-- end, { buffer = bufnr })

Also possible:
-- filter = function(clients)
--   return vim.tbl_filter(function(client)
--     return client.name ~= "tsserver" -- or client.name ~= "sumneko_lua"
--   end, clients)
-- end,
Disadvantage: Hardcoding servers outside of their opts...

Explicitly opt in or opt out:
For the moment, opt out explicitly sets null-ls as the LSP to format with

--]]

-- local util = require 'vim.lsp.util'
local M = {}
local format_on_save = true
local augroup = vim.api.nvim_create_augroup("ak_lsp_format_on_save", {})

-- Only lsp "client" will be used for formatting
local function opt_in(client, bufnr)
  vim.lsp.buf.format {
    id = client.id,
    bufnr = bufnr,
  }
end

-- Only lsp "null-ls" will be used for formatting
-- local function opt_out(client, bufnr)
local function opt_out(_, bufnr)
  -- print("Client opting out:", client.id)
  vim.lsp.buf.format {
    -- filter = function(_client)
    --   -- print("Received :", _client.name)
    --   -- -- Received : sumneko_lua
    --   -- -- Received : null-ls
    --   return _client.id ~= client.id
    -- end,
    name = "null-ls",
    bufnr = bufnr,
  }
end

local function add_autocmd(client, bufnr, clb)
  if client.supports_method "textDocument/formatting" then
    vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        if format_on_save then
          clb(client, bufnr)
        end
      end,
    })
  end
end

local function add_format_key(client, bufnr, clb)
  -- suggested mapping <space>f
  vim.keymap.set("n", "<leader>lf", function()
    clb(client, bufnr)
  end, { buffer = bufnr, desc = "LSP format buffer" })
end

local function add_toggle_key()
  vim.keymap.set("n", "<leader>lt", function()
    format_on_save = not format_on_save
  end, { desc = "LSP toggle format buffer on save" })
end

local function on_attach(client, bufnr, callback)
  add_format_key(client, bufnr, callback)
  add_autocmd(client, bufnr, callback)
  add_toggle_key()
end

-- use case: multiple lsp attached to buffer. Choose only this client
function M.on_attach_opt_in(client, bufnr)
  on_attach(client, bufnr, opt_in)
end

-- use case: 1 lsp and null_ls attached to buffer. Choose null_ls
function M.on_attach_opt_out(client, bufnr)
  on_attach(client, bufnr, opt_out)
end

return M
