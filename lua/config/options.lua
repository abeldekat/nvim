-- LazyVim: vim.g.mapleader = " " vim.g.maplocalleader = "\\"

-- basic
vim.opt.showtabline = 0 -- never show tabs, 1 is default, 2, -- always show tabs
vim.opt.colorcolumn = "80"
vim.opt.cmdheight = 0

-- splits
-- vim.opt.splitbelow = false -- Put new windows below current
-- vim.opt.splitright = false -- Put new windows right of current

-- without which-key, 300  seconds is too fast.
vim.opt.timeoutlen = 600 --300

-- checkhealth:
vim.g.python3_host_prog = "/usr/bin/python" -- archlinux: global python-pynvim

-- maybe:
-- vim.g.loaded_python3_provider = 0
-- vim.g.loaded_perl_provider = 0
-- vim.g.loaded_ruby_provider = 0
-- vim.g.loaded_node_provider = 0
