--[[
Options per lsp can also be consulted in nlsp-settings.nvim
Example pyright:
nlsp-settings.nvim/schemas/_generated/pyright.json

DEBUG:
  -- ./.local/state/nvim/lsp.log
  -- vim.lsp.set_log_level "debug"
--]]

local ok, lspc = pcall(require, "lspconfig")
if not ok then
  return
end

local lspclients = require "ak.lsp.clients"
local deferred_keymapping = "<leader>ld"

local function activate(clients)
  for _, client in ipairs(clients) do
    local opts = require("ak/lsp/opts/" .. client.name)
    if client.cmd_env then
      opts.cmd_env = client.cmd_env()
    end
    lspc[client.name].setup(opts)
  end
end

local function activate_deferred()
  activate(lspclients.deferred)
  vim.cmd [[:e]]
  vim.api.nvim_echo({ { "Loaded deferred lsp's and connected active buffer... Removing keymap..." } }, true, {})
  vim.keymap.del("n", deferred_keymapping)
end

activate(lspclients.active)

-- KEY: Global LSP
-- see also: telescope and buffer keymappings
vim.keymap.set("n", deferred_keymapping, function()
  activate_deferred()
end, { desc = "LSP: Load all lsp configs which are not active at start" })
vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<cr>", { desc = "LSP Info(nvim-lsp-config)" })
vim.keymap.set(
  "n",
  "<leader>lI",
  "<cmd>packadd nvim-lsp-installer | LspInstallInfo<cr>",
  { desc = "LSP Installer Info(nvim-lsp-installer)" }
)
