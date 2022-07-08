-- lvim ctrl-t: count is default 1
-- lvim lazygit leadergg count is 2
-- lvim lazygit ctrl-\ count is 3
-- lvim lazygit only changes count, direction and command

local ok, terminal = pcall(require, "toggleterm.terminal")
if not ok then
  return
end

local log_viewer_cmd = "lnav" -- less +F
local lazygit_cmd = "lazygit"

local config = {
  -- size can be a number or function which is passed the current terminal
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
  open_mapping = [[<c-\>]],
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  shade_terminals = false,
  shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  persist_size = true,
  -- direction = 'vertical' | 'horizontal' | 'window' | 'float',
  direction = "horizontal",
  close_on_exit = true, -- close the terminal window when the process exits
  shell = vim.o.shell, -- change the default shell
  -- This field is only relevant if direction is set to 'float'
  float_opts = {
    -- The border key is *almost* the same as 'nvim_win_open'
    -- see :h nvim_win_open for details on borders however
    -- the 'curved' border is a custom border type
    -- not natively supported but implemented in this plugin.
    -- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
    border = "curved",
    -- width = <value>,
    -- height = <value>,
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
}

local lazygit_term_marker = nil

local obtain_lazygit_term = function()
  if not lazygit_term_marker then
    lazygit_term_marker = terminal.Terminal:new {
      cmd = lazygit_cmd,
      hidden = true,
      direction = "float",
      size = 20,
    }
  end
  return lazygit_term_marker
end

local toggle_lazygit = function()
  local lazygit_term = obtain_lazygit_term()
  if lazygit_term then
    lazygit_term:toggle()
  end
end

local toggle_log_view = function(logfile)
  local log_view_term = terminal.Terminal:new {
    cmd = log_viewer_cmd .. " " .. logfile,
    hidden = true,
    direction = "horizontal",
    size = 20,
  }
  log_view_term:toggle()
end

require("toggleterm").setup(config)

local keymap = vim.keymap

-- KEY: Terminal git and log
--stylua: ignore start
keymap.set("n", "<leader>gg", toggle_lazygit, { desc = "Lazygit in terminal" })
-- keymap.set("n", "<leader>Ld", function() toggle_log_view(require("ak.core.log").get_path()) end, { desc = "Terminal Default log viewer" })
keymap.set("n", "<leader>Ll", function() toggle_log_view(vim.lsp.get_log_path()) end, { desc = "Terminal Lsp log viewer" })
keymap.set("n", "<leader>Ln", function() toggle_log_view(os.getenv "NVIM_LOG_FILE") end, { desc = "Terminal Neovim log viewer" })
keymap.set("n", "<leader>Lp", function() toggle_log_view(vim.fn.stdpath("cache") .. "/packer.nvim.log") end, { desc = "Terminal Packer log viewer" })
--stylua: ignore end
