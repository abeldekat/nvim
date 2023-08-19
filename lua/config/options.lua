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
-- vim.opt.cmdheight = 0
vim.opt.showtabline = 0 -- never show tabs, 1 is default, 2, -- always show tabs
vim.opt.colorcolumn = "80"

-- splits
-- vim.opt.splitbelow = false -- Put new windows below current
-- vim.opt.splitright = false -- Put new windows right of current

-- without which-key, 300  seconds is too fast.
vim.opt.timeoutlen = 600 --300

-- folding
vim.opt.foldlevel = 99 -- set high foldlevel for nvim-ufo
vim.opt.foldlevelstart = 99 -- start with all code unfolded
vim.opt.foldenable = true
vim.opt.foldcolumn = "0"
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- checkhealth:
vim.g.python3_host_prog = "/usr/bin/python" -- archlinux: global python-pynvim

-- TODO: Find out what this means:
-- vim.g.loaded_python3_provider = 0
-- vim.g.loaded_perl_provider = 0
-- vim.g.loaded_ruby_provider = 0
-- vim.g.loaded_node_provider = 0
