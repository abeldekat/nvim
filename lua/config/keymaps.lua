-- Keymaps are automatically loaded on the VeryLazy event
--
-- disabled bufferline, removes mappings pin with leader bP and bp
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

-- copied from lazyvim keymaps.lua:
local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

--------------------------------------------------------------------------
-- Delete mappings, making l, w and q menus available
--------------------------------------------------------------------------

for _, key in pairs({
  "<c-/>", -- dummy which key, lazyterm
  "<S-h>", -- bprev
  "<S-l>", -- bnext
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

-- right hand improvement:
-- c-n can behave like j and enter, also sometimes "next":
map("n", "<C-N>", "<C-d>zz", { desc = "Dow[n] half page, better ctrl-d" })

--------------------------------------------------------------------------
-- Add mappings
--------------------------------------------------------------------------

-- Add show tabs to tabs submenu
map("n", "<leader><tab>s", "<cmd>tabs<cr>", { desc = "[S]how Tabs" })

-- Remap all leader q mappings, see unmap above
-- Step 1: See plugins, util, persistence, override q keys
-- Step 2: map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "[Q]uit" })
-- Lazy uses ctrl-s
map("n", "<leader>w", "<cmd>w<cr><esc>", { desc = "[W]rite" })

-- Remap lazy ui, leader l now available, see unmap above
map("n", "<leader>mz", "<cmd>Lazy<cr>", { desc = "La[z]y" })
-- LazyVim Changelog, see unmap above
map("n", "<leader>mC", Util.changelog, { desc = "Lazy [c]hangelog" })

--------------------------------------------------------------------------
-- Primeagen:
--------------------------------------------------------------------------

-- lessons:
-- use yiw/yiW
-- overshoot is ok
-- use %, use paragraph
-- go one down, and use yi{}
-- remember di, with cursor before. No need to navigate

-- "The greatest remap ever..."
-- ...But v_P is also good... Now using mini.operators
-- map("x", "<leader>p", '"_dP', { desc = "Enhanced paste. Delete to sink" })

-- Not compatible with mini.animate:
map("n", "<C-d>", "<C-d>zz", { desc = "better ctrl-d" })
map("n", "<C-u>", "<C-u>zz", { desc = "better ctrl-u" })

--------------------------------------------------------------------------
-- Remember:
-- c-w T convert split to tab, c-w c close window, c-w o only
-- c-w n: new file in split
-- c-w p: previous window
-- c-w x: swap current with next
-- c-w w: switch windows
-- :tab help -- open help in new tab
