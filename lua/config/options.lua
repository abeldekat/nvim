-- LazyVim
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = "\\"

-- TODO:
-- vim.opt.listchars = "tab:▸ ,trail:·,nbsp:␣,extends:❯,precedes:❮" -- show symbols for whitespace
-- vim.opt.listchars = "trail:·,nbsp:◇,tab:→ ,extends:▸,precedes:◂"

-- TODO:
-- vim.opt.fillchars = {
--   foldopen = "",
--   foldclose = "",
--   fold = " ",
--   foldsep = " ",
--   diff = "╱",
--   eob = " ",
-- }

-- basic
vim.opt.showtabline = 0 -- never show tabs, 1 is default, 2, -- always show tabs
vim.opt.colorcolumn = "80"

-- splits
-- vim.opt.splitbelow = false -- Put new windows below current
-- vim.opt.splitright = false -- Put new windows right of current

-- without which-key, 300  seconds is too fast.
vim.opt.timeoutlen = 600 --300

-- folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99

-- checkhealth:
vim.g.python3_host_prog = "/usr/bin/python" -- archlinux: global python-pynvim

-- TODO:
-- vim.g.loaded_python3_provider = 0
-- vim.g.loaded_perl_provider = 0
-- vim.g.loaded_ruby_provider = 0
-- vim.g.loaded_node_provider = 0
