-- Keymaps are automatically loaded on the VeryLazy event
-- Add any additional keymaps here
--
-- disabled bufferline, removes mappings pin with leader bP and bp
-- disabled neotree: leader e available
-- remapped lazy "leader l" to leader zz: leader l available
-- remapped persistence to "leader z": leader q available
-- remapped all "leader w": leader w available
--
-- Important differences: Old neovim config to stock lazy:
-- Buffers: "leader r" is "leader ,"
-- Find files: "leader e" is leader leader(git files...)
-- Live grep: "leader r" is "leader /"
-- Recent files: "leader o" is "leader fr"
-- Alternate: "leader a" is "leader `"
-- Split window: is "leader -" and "leader |"
--
-- new file browse design:
--
-- "leader l": not needed, available
-- "leader ,": not needed, available
-- "leader b": mini.bufremove, not needed
-- "leader leader": harpoon ui
-- "leader o": telescope open buffers
-- "leader /": telescope current buffer search
-- "leader e": telescope git files
-- "leader r": telescope grep files
-- "leader ?": telescope oldfiles, current working dir
--
-- "mk": oil(replacing lir)
-- "ml": mini file browser

-- See lazyvim config keymaps.lua, without the lazy keymaps check
local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

--------------------------------------------------------------------------
-- Delete mappings, making l, w and q menus available
for _, key in pairs({
  "<c-/>", -- dummy which key, lazyterm
  "<S-h>", -- bprev
  "<S-l>", -- bnext
  "<leader>l", -- lazy
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
-- see editor, overriding <c-/> with toggleterm

--------------------------------------------------------------------------
-- Add mappings
-- Add show tabs to tabs submenu
map("n", "<leader><tab>s", "<cmd>tabs<cr>", { desc = "[S]how Tabs" })
-- Remap all leader q mappings, see unmap above
-- Step 1: See plugins, util, persistence, override q keys
-- Step 2: map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Faster [Q]uit" })
-- Lazy uses ctrl-s
map("n", "<leader>w", "<cmd>w<cr><esc>", { desc = "Faster [W]rite" })
-- Remap lazy ui, leader l now available, see unmap above
map("n", "<leader>mz", "<cmd>Lazy<cr>", { desc = "La[Z]y Command" })

--------------------------------------------------------------------------
-- Primeagen:
-- lessons:
-- use yiw/yiW
-- overshoot is ok
-- use %, use paragraph
-- go one down, and use yi{}
-- remember di, with cursor before. No need to navigate

-- "The greatest remap ever..."
map("x", "<leader>p", '"_dP', { desc = "Enhanced paste. Delete to sink" })

-- No luck with animation:
-- map("n", "<C-d>", "<C-d>zz", { desc = "better ctrl-d" })
-- map("n", "<C-u>", "<C-u>zz", { desc = "better ctrl-u" })

-- right hand improvement, override native L
map("n", "L", "<C-d>", { desc = "[L]ower half page, better ctrl-d" })

--------------------------------------------------------------------------
-- Remember:
-- :tab help -- open help in new tab
