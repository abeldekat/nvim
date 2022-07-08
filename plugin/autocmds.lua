-- TODO: Bufwritepost, packer auto compile
local api = vim.api
local cmd = vim.cmd
local highlight = vim.highlight
local keymap = vim.keymap

local general_settings = vim.api.nvim_create_augroup("ak_general_settings", {})
api.nvim_create_autocmd("FileType", {
  pattern = { "qf", "help", "man", "lspinfo", "lsp-installer", "null-ls-info" },
  callback = function()
    keymap.set("n", "q", "<cmd>close<cr>", { silent = true, buffer = 0, desc = "Close buffer directly with q" })
  end,
  group = general_settings,
  desc = "Close buffer with q",
})
api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    cmd [[ set nobuflisted ]]
  end,
  group = general_settings,
  desc = "Prevent Quickfix from appearing in the bufferlist",
})
api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    highlight.on_yank { higroup = "Search", timeout = 200 }
  end,
  group = general_settings,
  desc = "Highlight on yank",
})

local formatoptions = vim.api.nvim_create_augroup("ak_formatoptions", {})
api.nvim_create_autocmd({ "BufWinEnter", "BufRead", "BufNewFile" }, {
  pattern = "*",
  -- formatoptions influences how Vim formats text. default: "tcqj"
  -- c = comments, r and o handle automatic insertion of current comment leader
  callback = function()
    cmd [[ setlocal formatoptions-=c formatoptions-=r formatoptions-=o ]]
  end,
  group = formatoptions,
  desc = "Set format options",
})

local spell = vim.api.nvim_create_augroup("ak_spell", {})
api.nvim_create_autocmd("FileType", {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    cmd [[ setlocal wrap ]]
    cmd [[ setlocal spell ]]
  end,
  group = spell,
  desc = "Settings for filetype with spell, set to gitcommit and markdown",
})

-- local cmdline = vim.api.nvim_create_augroup("ak_cmd_msg_cls", {})
-- api.nvim_create_autocmd("CmdlineLeave", {
--   callback = function()
--     local function empty_message()
--       -- if vim.fn.mode() == "n" then
--       cmd [[echon '']]
--       -- end
--     end
--     vim.fn.timer_start(5000, empty_message)
--   end,
--   group = cmdline,
--   desc = "Automatically clear the commandline after 5 seconds",
-- })

-- local auto_resize = vim.api.nvim_create_augroup("ak_auto_resize", {})
-- api.nvim_create_autocmd("VimResized", {
--   pattern = "*",
-- { "VimResized", "*", "tabdo wincmd =" },
--   callback = function()
--     cmd "tabdo wincmd ="
--   end,
--   group = auto_resize,
--   desc = "Resize split windows evenly if main window is resized",
-- })
