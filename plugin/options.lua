-- TODO treesitter folding
-- set foldmethod=expr
-- set foldexpr=nvim_treesitter#foldexpr()

-- latex:
-- breakindent for latex?
-- linebreak for latex?
-- fillchars for latex?
-- vim.opt.showbreak = '↳ ' -- String to put at the start of lines that have been wrapped
-- vim.opt.whichwrap = 'b,s,h,l,<,>,[,]' -- move the cursor left/right to move to the previous/next line

-- local g = vim.g
local opt = vim.opt
-- local cmd = vim.cmd
local fn = vim.fn

local default_options = {
  backup = false, -- creates a backup file
  clipboard = "unnamedplus", -- allows neovim to access the system clipboard
  cmdheight = 1, -- more space in the neovim command line for displaying messages
  colorcolumn = "99999", -- fixes indentline for now
  completeopt = { "menu", "menuone", "noselect" },
  conceallevel = 0, -- so that `` is visible in markdown files
  fileencoding = "utf-8", -- the encoding written to a file
  foldmethod = "manual", -- folding, set to "expr" for treesitter based folding
  foldexpr = "", -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
  guifont = "monospace:h17", -- the font used in graphical neovim applications
  hidden = true, -- required to keep multiple buffers and open multiple buffers
  hlsearch = true, -- highlight all matches on previous search pattern
  ignorecase = true, -- ignore case in search patterns
  mouse = "a", -- allow the mouse to be used in neovim
  pumheight = 10, -- pop up menu height
  showmode = false, -- we don't need to see things like -- INSERT -- anymore
  showtabline = 1, -- never show tabs, 1 is default, 2, -- always show tabs
  smartcase = true, -- smart case
  smartindent = true, -- make indenting smarter again
  -- splitbelow = true, -- force all horizontal splits to go below current window
  -- splitright = true, -- force all vertical splits to go to the right of current window
  swapfile = false, -- creates a swapfile
  termguicolors = true, -- set term gui colors (most terminals support this)
  -- timeoutlen = 1000, -- 1000 default, time to wait for a mapped sequence to complete (in milliseconds)
  title = true, -- set the title of window to the value of the titlestring
  -- opt.titlestring = "%<%F%=%l/%L - nvim" -- what the title of the window will be set to
  undodir = fn.stdpath "cache" .. "/undo",
  undofile = true, -- enable persistent undo
  updatetime = 1000, --300, -- faster completion
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true, -- convert tabs to spaces
  shiftwidth = 2, -- the number of spaces inserted for each indentation
  tabstop = 2, -- insert 2 spaces for a tab
  cursorline = true, -- highlight the current line
  number = true, -- set numbered lines
  relativenumber = false, -- set relative numbered lines
  numberwidth = 4, -- set number column width to 2 {default 4}
  signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
  wrap = false, -- display lines as one long line
  spell = false,
  spelllang = "en",
  -- Name of the word list file where words are added for the |zg| and |zw| commands:
  spellfile = fn.stdpath "config" .. "/spell/en.utf-8.add",
  -- shadafile = join_paths(get_cache_dir(), "lvim.shada"),
  scrolloff = 8, -- minimal number of screen lines to keep above and below the cursor.
  sidescrolloff = 8, -- minimal number of screen lines to keep left and right of the cursor.
}

local load_default_options = function()
  -- vim.opt.shortmess:append "I" -- don't show the default intro message
  -- vim.opt.whichwrap:append "<,>,[,],h,l"
  vim.opt.shortmess:append "c"

  for k, v in pairs(default_options) do
    opt[k] = v
  end

  -- Consider - as part of a word
  -- vimcmd [[set iskeyword+=-]]

  -- Copied from old vimrc. Better navigation from command line
  -- vimcmd [[set path+=**]]
end

local load_headless_options = function()
  opt.shortmess = "" -- try to prevent echom from cutting messages off or prompting
  opt.more = false -- don't pause listing when screen is filled
  opt.cmdheight = 9999 -- helps avoiding |hit-enter| prompts.
  opt.columns = 9999 -- set the widest screen possible
  opt.swapfile = false -- don't use a swap file
end

if #vim.api.nvim_list_uis() == 0 then
  load_headless_options()
  return
end
load_default_options()
