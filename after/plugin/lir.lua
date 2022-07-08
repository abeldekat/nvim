-- TODO: Lir mmv, Rename multiple files using your $EDITOR. The command name is named after multi-mv.
local status_ok, lir = pcall(require, "lir")
if not status_ok then
  return
end

local actions = require "lir.actions"
local mark_actions = require "lir.mark.actions"
local clipboard_actions = require "lir.clipboard.actions"
local has_devicons, _ = pcall(require, "nvim-web-devicons")
local has_lir_git_status, lir_git_status = pcall(require, "lir.git_status")

local function toggle_file_explorer_floating()
  require("lir.float").toggle()
end

local function toggle_file_explorer()
  vim.cmd [[execute 'e ' .. expand('%:p:h')]]
end

local function git_status_change_hl()
  vim.cmd [[
    highlight link LirGitStatusBracket Comment
    highlight link LirGitStatusIndex Special
    highlight link LirGitStatusWorktree WarningMsg
    highlight link LirGitStatusUnmerged ErrorMsg
    highlight link LirGitStatusUntracked Comment
    highlight link LirGitStatusIgnored Commentd
]]
end

local function on_init()
  -- use visual mode
  vim.api.nvim_buf_set_keymap(
    0,
    "x",
    "J",
    ':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>',
    { noremap = true, silent = true }
  )
end

local function mark()
  mark_actions.toggle_mark()
  vim.cmd "normal! j"
end

local float = {
  winblend = 0,
  curdir_window = {
    enable = false,
    highlight_dirname = true,
  },

  -- -- You can define a function that returns a table to be passed as the third
  -- -- argument of nvim_open_win().
  win_opts = function()
    local width = math.floor(vim.o.columns * 0.5)
    local height = math.floor(vim.o.lines * 0.5)
    return {
      border = "rounded",
      width = width,
      height = height,
      -- row = 1,
      -- col = math.floor((vim.o.columns - width) / 2),
    }
  end,
}

--[[
  faster splits, buftype lir:
  not using leap, but f, F, HML, so s is safe:
  only use visual line V, so v is safe
  no using "till"(t) here, so t is safe
  not using y, overriding y is safe

  letters in use:
  A,a,c,d,D,h,i,J,l,p,q,r,s,t,v,x,Y
  @
  lir telescope: d,y
--]]

-- KEY: Lir buffer keymappings
-- See also: telescope lir...
local mappings = {

  ["l"] = actions.edit,
  ["h"] = actions.up,

  -- ["<C-s>"] = actions.split,
  ["s"] = actions.split,
  ["v"] = actions.vsplit,
  -- ["<C-t>"] = actions.tabedit,
  ["t"] = actions.tabedit,

  ["q"] = actions.quit,

  ["A"] = actions.mkdir,
  ["a"] = actions.newfile,
  ["r"] = actions.rename,
  ["@"] = actions.cd,
  ["Y"] = actions.yank_path,
  ["i"] = actions.toggle_show_hidden,
  -- ["d"] = actions.delete,
  ["D"] = actions.delete,

  ["J"] = function()
    mark()
  end,
  ["c"] = clipboard_actions.copy,
  ["x"] = clipboard_actions.cut,
  ["p"] = clipboard_actions.paste,
}

local config = {
  show_hidden_files = false,
  devicons_enable = has_devicons,
  mappings = mappings,
  float = float,
  hide_cursor = false,
  on_init = on_init,
}

lir.setup(config)

-- git status indicator
if has_lir_git_status then
  lir_git_status.setup {
    show_ignored = false,
  }
  git_status_change_hl()
end

-- custom folder icon
if has_devicons then
  require("nvim-web-devicons").set_icon {
    lir_folder_icon = {
      icon = "",
      -- color = "#7ebae4",
      color = "#569CD6",
      name = "LirFolderNode",
    },
  }
end

-- KEY: Lir
vim.keymap.set("n", "-", function()
  toggle_file_explorer_floating()
end, { desc = "Toggle Lir Simple File Explorer Floating" })

-- Using the mark keystroke family, see harpoon. Mnemonic: k for "up"
vim.keymap.set("n", "mk", function()
  toggle_file_explorer()
end, { desc = "Toggle Lir Simple File Explorer" })
