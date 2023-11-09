-- if true then return {} end
-- Keymaps are automatically loaded on the VeryLazy event
--
-- disabled bufferline, removes mappings pin with leader bP and bp
-- disabled mini.bufremove: leader b available
-- disabled neotree: leader e available
-- remapped persistence to "leader m": leader q available
-- removed all "leader w": leader w available

--------------------------------------------------------------------------
-- file navigation design:
--------------------------------------------------------------------------
-- "leader ,": unmapped, telescope switch buffer, harder to type
-- "leader space": LazyVim default, telescope files
-- "leader o": telescope switch buffer, list open buffers
--
-- "leader e": telescope live grep, replacing neotree
-- "leader /": telescope current buffer search, replacing telescope live grep
-- "leader r": telescope oldfiles, current working dir
--
-- special mark keys(k):
-- "mk": oil file browser (strongest rolling fingers...)
-- "ml": last accessed window
-- "mw": next window
-- "me": explore alternate( projectionist or telescope-alternate)
-- "ma ms md mf": undefined, reserved for marking inside buffer
--
-- harpoon leader:
-- "leader j": harpoon ui
-- "leader k": harpoon add(next to j)
-- "leader n": harpoon next
-- "leader p": harpoon prev

-- harpoon overriding window navigation:
-- "ctrl j": harpoon file 1
-- "ctrl k": harpoon file 2
-- "ctrl l": harpoon file 3
-- "ctrl h": harpoon file 4

local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  if opts.remap and not vim.g.vscode then
    opts.remap = nil
  end
  vim.keymap.set(mode, lhs, rhs, opts)
end

--------------------------------------------------------------------------
-- Delete mappings: b, w and q menus available
--------------------------------------------------------------------------

for _, key in pairs({
  "<S-h>", -- top instead of bprev
  "<S-l>", -- lower instead of bnext
  "<leader>bb", -- switch to other buffer, using: <leader>`
  "<leader>wd", -- delete window, <C-W>c, now just quit
  "<leader>ww", -- other window, <C-W>p, not necessary
  "<leader>w-", -- duplicate split window <C-W>s
  "<leader>w|", -- duplicate split window <C-W>v
  "<leader>qq", -- quit all
}) do
  vim.keymap.del("n", key)
end
for _, key in pairs({
  "<c-h>", -- harpoon consistency
  "<c-j>",
  "<c-k>",
  "<c-l>",
}) do
  vim.keymap.del("t", key)
end

-- save file with C-s in all modes
-- "s", -- stacktrace ...
for _, mode in pairs({ "i", "v", "n" }) do
  vim.keymap.del(mode, "<C-s>")
end

--------------------------------------------------------------------------
-- Change mappings
--------------------------------------------------------------------------

-- leader q now available:
map("n", "<leader>q", "<cmd>q<cr>", { desc = "[Q]uit" })
-- leader w now available. Lazy uses ctrl-s
map("n", "<leader>w", "<cmd>w<cr><esc>", { desc = "[W]rite" })

--------------------------------------------------------------------------
-- Add mappings
--------------------------------------------------------------------------

-- previous window:
map("n", "ml", "<C-W>p", { desc = "Last accessed window", remap = true })
map("n", "mw", "<C-W>w", { desc = "Next window", remap = true })

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
