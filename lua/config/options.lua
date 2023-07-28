-- checkhealth:
vim.g.python3_host_prog = "/usr/bin/python" -- archlinux: global python-pynvim

local opt = vim.opt
-- opt.splitbelow = false -- Put new windows below current
-- opt.splitright = false -- Put new windows right of current

opt.showtabline = 0 -- never show tabs, 1 is default, 2, -- always show tabs
opt.colorcolumn = "80"

-- without which-key, 300  seconds is too fast.
opt.timeoutlen = 600 --300
