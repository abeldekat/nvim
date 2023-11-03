-- if true then return {} end
-- Keymaps are automatically loaded on the VeryLazy event
--
-- disabled bufferline, removes mappings pin with leader bP and bp
-- disabled mini.bufremove: leader b available
-- disabled neotree: leader e available
-- remapped lazy "leader l" to leader zz: leader l available
-- remapped persistence to "leader z": leader q available
-- remapped all "leader w": leader w available
--
-- file navigation design:
--
-- "leader space": LazyVim default, telescope files
-- "leader o": telescope switch buffer
-- "leader ,": harpoon ui, replacing telescope switch buffer
--
-- "leader h": harpoon file 1
-- "leader j": harpoon file 2
-- "leader k": harpoon file 3
-- "leader l": harpoon file 4
--
-- "leader e": telescope live grep, replacing neotree
-- "leader /": telescope current buffer search, replacing telescope live grep
-- "leader r": telescope oldfiles, current working dir
--
-- Special mark keys(a, k, l):
-- "ma": harpoon add
-- "mk": oil file browser (strongest rolling fingers...)
-- "ml": mini file browser

local Util = require("lazyvim.util")

local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  if opts.remap and not vim.g.vscode then
    opts.remap = nil
  end
  vim.keymap.set(mode, lhs, rhs, opts)
end

--------------------------------------------------------------------------
-- Delete mappings, making l, w and q menus available
--------------------------------------------------------------------------

for _, key in pairs({
  "<c-/>", -- dummy which key, lazyterm
  "<S-h>", -- bprev
  "<S-l>", -- bnext
  "<leader>bb", -- switch to other buffer, using: <leader>`
  -- "<leader>l", -- lazy, now harpoon 4
  "<leader>L", -- lazy changelog
  "<leader>wd", -- delete window, <C-W>c, now just quit
  "<leader>ww", -- other window, <C-W>p, not necessary
  "<leader>w-", -- duplicate split window <C-W>s
  "<leader>w|", -- duplicate split window <C-W>v
  "<leader>qq", -- quit all
}) do
  vim.keymap.del("n", key)
end

-- save file with C-s in all modes
-- "s", -- stacktrace ...
for _, mode in pairs({ "i", "v", "n" }) do
  vim.keymap.del(mode, "<C-s>")
end

--------------------------------------------------------------------------
-- Change mappings
--------------------------------------------------------------------------

-- see editor, overriding <c-/> with toggleterm

-- Remap all leader q mappings, see unmap above
-- Step 1: See plugins, util, persistence, override q keys
-- Step 2: map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "[Q]uit" })
-- Lazy uses ctrl-s
map("n", "<leader>w", "<cmd>w<cr><esc>", { desc = "[W]rite" })

-- Remap lazy ui, leader l now available, see unmap above
map("n", "<leader>ml", "<cmd>Lazy<cr>", { desc = "[L]azy" })
-- LazyVim Changelog, see unmap above
map("n", "<leader>mc", function()
  Util.news.changelog()
end, { desc = "Lazy [c]hangelog" })

--------------------------------------------------------------------------
-- Add mappings
--------------------------------------------------------------------------

-- Switch tabs
map("n", "<leader>1", "1gt", { desc = "Move to tab 1" })
map("n", "<leader>2", "2gt", { desc = "Move to tab 2" })
map("n", "<leader>3", "3gt", { desc = "Move to tab 3" })
-- Add show tabs to tabs submenu
map("n", "<leader><tab>s", "<cmd>tabs<cr>", { desc = "[S]how Tabs" })

-- v_P is also good... Using substitute.nvim
-- map("x", "<leader>p", '"_dP', { desc = "Enhanced paste. Delete to sink" })

-- right hand improvement:
-- c-n can behave like j and enter, also sometimes "next":
map("n", "<C-N>", "<C-d>zz", { desc = "Dow[n] half page, better ctrl-d" })

-- Not compatible with animate:
map("n", "<C-d>", "<C-d>zz", { desc = "better ctrl-d" })
map("n", "<C-u>", "<C-u>zz", { desc = "better ctrl-u" })
