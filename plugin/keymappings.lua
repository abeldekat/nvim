-- All key sections in config files are marked for Todo-comment plugin
-- practice:
-- xnoremap il g_o^
-- onoremap il :normal vil
-- todo map to plug PlenaryTestFile

local fn = vim.fn
local cmd = vim.cmd
local lsp = vim.lsp

-- Helpers
local setter = vim.keymap.set
local function map(mode, key, rhs, desc)
  setter(mode, key, rhs, { desc = desc, silent = true })
end

local function nmap(key, rhs, desc)
  setter("n", key, rhs, { desc = desc, silent = true })
end

local function nmap_cmd(key, rhs, desc)
  local result = string.format("<Cmd>%s<CR>", rhs)
  setter("n", key, result, { desc = desc, silent = true })
end

local function nmap_cmd_interactive(key, rhs, desc)
  local result = string.format(":%s<CR>", rhs)
  setter("n", key, result, { desc = desc, silent = true })
end

-- Faster escape, always hinders typing:
-- vim.keymap.set("i", "jk", "<ESC>", { desc = "Faster escape", silent = true })

-- KEY: Direct bindings
-- m, harpoon, lir, git status with telescope
-- gn etc, gr etc: Treesitter incremental selection
-- g and [], buffer scoped mappings: builtin LSP and Diagnostic
-- [] with unimpaired, or with c and l

--[[
leader available letters:
k,n,p,u,v,y
capitals in use:
C,D,L,R,T
]]

-- KEY: Leader single
-- a alternate file
nmap("<leader>a", "<c-^>", "Alternate buffer")
-- b current buffer fuzzy --telescope,
-- c close buffer
nmap_cmd("<leader>c", "bdelete", "Close buffer")
nmap_cmd("<leader>C", "bdelete!", "Close buffer")
-- e search files --telescope
-- h no hlsearch
nmap_cmd("<leader>h", "nohlsearch", "No highlight")
-- normal mode enter clears hlsearch when active
-- vim.cmd [[nnoremap <expr> <CR> {-> v:hlsearch ? ":nohl\<CR>" : "\<CR>"}()]]
-- i buffer info
nmap("<leader>i", "2<c-g>", "Buffer info 2<c-g>")
nmap("<leader>j", function()
  vim.cmd [[echon '']]
end, "Remove remaining message from the command line")
-- n change colorscheme with telescope
-- o oldfiles -- telescope
-- r search buffers, -- telescope
-- t builtin telescope
-- w  w write: Allow for CmdLineLeave event to be triggered
nmap_cmd_interactive("<leader>w", "w", "Write")
-- q quit
nmap_cmd("<leader>q", "q", "Quit")
-- s color contrast
-- x color palette
-- z color switch background
-- Z color switch background preference
-- / toggle comment linewise --comment.nvim
-- gt shortcuts
for i = 1, 9, 1 do
  nmap("<leader>" .. i, i .. "gt", "Easier switch to tabs")
end
-- - lir file explorer floating


-- stylua: ignore start

-- KEY: Leader menu
-- d diagnostics telescope, quickfix, trouble
-- D debug: all nvim-dap commands. Mnemonic execute debug commands
-- f search, find, vim specific with telescope, projects
-- g(git with telescope, gitsigns and terminal)
-- l lsp, diagnostics, telescope
-- L log, with terminal, lnav and log
-- nmap("<leader>LD", function() fn.execute("edit " .. Log:get_path()) end, "Open default logfile")
nmap("<leader>LN", function() fn.execute("edit " .. os.getenv('NVIM_LOG_FILE')) end, "Open neovim logfile")
nmap("<leader>LL", function() fn.execute("edit " .. lsp.get_log_path()) end, "Open LSP logfile")
nmap("<leader>LP", function() fn.execute("edit " .. fn.stdpath('cache') .. '/packer.nvim.log') end, "Open packer logfile")
-- m (mnemonic misc), activate plugin loader, lualine tab rename, toggle zenmode,
nmap("<leader>md", function() require("pa.invoke").load_core_collection_and_colors() end, "Lazy load packer config core and colors")
nmap("<leader>mD", function() require("pa.invoke").load_core_collection() end, "Lazy load packer config core")
nmap("<leader>ms", function() require("pa.invoke").load_nth_collection_and_colors() end, "Lazy load packer config nth and colors")
nmap("<leader>mS", function() require("pa.invoke").load_nth_collection() end, "Lazy load packer config nth")
nmap("<leader>mc", function() require("pa.invoke").load_color_collection() end, "Lazy load packer colors")
nmap("<leader>ma", function() require("pa.invoke").load_all_collection() end, "Lazy load packer config all")
-- R debug: Telescope, dapui. Mnemonic request debug info
-- T treesitter
-- stylua: ignore end

-- KEY: Leader double, command line related
-- note that <cmd> requires <cr>
-- nmap_cmd("<leader><leader>x", "silent w | source %", "Write and source a file, neovim as a repl...")
setter("n", "<leader><leader>x", ":call ak#save_and_exec()", { desc = "Write and source a file, neovim as a repl..." })
setter("n", "<leader><leader>c", ":<up>", { desc = "Run the last command" })
setter("n", "<leader><leader>m", "<cmd>Messages<cr>", { desc = ":messages loaded in the quickfix list, scriptease" })
setter("n", "<leader><leader>t", ":tab", { desc = "Commandline: Start with the word tab and use completion" })
setter("n", "<leader><leader>T", ":Todo", { desc = "Commandline: Start with the word TODO and use completion" })
setter("n", "<leader><leader>p", ":Packer", { desc = "Commandline: Start with the word Packer and use completion" })

-- KEY: Generic

-- Window movement: tmux-navigator in use, normal mode
-- Term window navigation
map("t", "<leader><esc>", "<C-\\><C-N>", "Terminal to normal mode, single escape is for zsh vim mode")
map("t", "<esc><esc>", "<C-\\><C-N>", "Terminal to normal mode, single escape is for zsh vim mode")
map("t", "<C-h>", "<C-\\><C-N><C-w>h", "Terminal mode split navigation h")
map("t", "<C-j>", "<C-\\><C-N><C-w>j", "Terminal mode split navigation j")
map("t", "<C-k>", "<C-\\><C-N><C-w>k", "Terminal mode split navigation k")
map("t", "<C-l>", "<C-\\><C-N><C-w>l", "Terminal mode split navigation l")

--Resize
-- m,./ like hjkl
nmap("<A-m>", "<C-W>5<", "Resize 5 left")
nmap("<A-,>", "<C-W>2+", "Resize 2 down")
nmap("<A-.>", "<C-W>2-", "Resize 2 up")
nmap("<A-/>", "<C-W>5>", "Resize 5 right")
nmap("<leader>=", "<C-W>=", "Resize equal")

-- " Move line(s) up and down
setter("n", "<M-j>", ":m .+1<CR>==", { desc = "Move current line down" })
setter("n", "<M-k>", ":m .-2<CR>==", { desc = "Move current line up" })
setter("i", "<M-j>", "<ESC>:m .+1<CR>==gi", { desc = "Move current line down" })
setter("i", "<M-k>", "<ESC>:m .-2<CR>==gi", { desc = "Move current line up" })
-- Maybe :m '>+1<CR>gv-gv
setter("v", "<M-j>", ":move '>+1<CR>gv=gv", { desc = "Move current line down" })
setter("v", "<M-k>", ":move '<-2<CR>gv=gv", { desc = "Move current line up" })

-- Switch between tabs
nmap("<Right>", function()
  vim.cmd [[checktime]]
  vim.api.nvim_feedkeys("gt", "n", true)
end, "Switch tabs with right arrow")
nmap("<Left>", function()
  vim.cmd [[checktime]]
  vim.api.nvim_feedkeys("gT", "n", true)
end, "Switch tabs with left arrow")

-- Visual mode indenting
map("v", "<", "<gv", "Visual mode indent repeating")
map("v", ">", ">gv", "Visual mode indent repeating")

-- QuickFix, unimpaired is also an option:
vim.cmd [[
nnoremap ]q :cnext<CR>
nnoremap [q :cprev<CR>
nnoremap ]l :lnext<CR>
nnoremap [l :lprevious<CR>
]]
nmap("<C-q>", function()
  if fn.empty(fn.filter(fn.getwininfo(), "v:val.quickfix")) == 1 then
    cmd [[ copen ]]
  else
    cmd [[ cclose]]
  end
end, "Toggle Quickfix Window")

-- Insert mode, line above or below. Does not work...
-- map("i", "<S-CR>", "<C-O>o", "Add line below in insert mode")
-- map("i", "<C-CR>", "<C-O>O", "Add line above in insert mode")

-- Visual mode put:
-- ["p"] = '"0p',
-- ["P"] = '"0P',

-- " Helpful delete/change into blackhole buffer
-- nmap <leader>d "_d
-- nmap <leader>c "_c
-- nmap <space>d "_d
-- nmap <space>c "_c

-- From old vimrc:
-- " Windows navigation and splits, will be overwritten by tmux_navigator.vim
-- " plugin. Plugins are loaded after vimrc, see help startup
-- " Also: on source vimrc the mappings below will apply thus overwriting the
-- " functions tmux-navigator calls. So, only nnoremap if there is no
-- " tmux_navigator
-- if !exists("g:loaded_tmux_navigator")
--     nnoremap <C-h> <C-w>h
--     nnoremap <C-j> <C-w>j
--     nnoremap <C-k> <C-w>k
--     nnoremap <C-l> <C-w>l
--     nnoremap <C-\> <C-w>p
-- endif
-- " Easier split, c-s is available
-- nnoremap <C-s> <C-w>s
-- " Easier split, c-v is not available, this activates visual block mode
-- " Choice: block mode is also available from visual mode by pressing ctr-v.
-- " Quick splits are now more valuable than blockmode when there is a workaround
-- " Alternative: leader s and v
-- nnoremap <C-v> <C-w>v

-- From old vimrc:
-- " Reminders
-- "
-- " New window empty file
-- " ctrl + w n
-- " Split current window in two.  Edit file name under cursor.
-- " ctrl-w f
-- "Max out the height of the current split
-- " ctrl + w _
-- "Max out the width of the current split
-- " ctrl + w |
-- "Normalize all split sizes, which is very handy when resizing terminal
-- " ctrl + w =
-- "Rotate
-- " Ctrl+W R
-- "Exchange
-- " Ctrl+W x
-- "Break out current window into a new tabview
-- " Ctrl+W T
-- "Close every window in the current tabview but the current one
-- " Ctrl+W o
-- " Does :split #, split window in two and edit alternate file. When a count is given, it becomes :split #N, split window and edit buffer N.
-- " Ctrl-W ^
-- " move cursor to top bottom or last accessed window
-- " Ctrl+W t,b,p
-- " move to preview window
-- " Ctrl+W P
