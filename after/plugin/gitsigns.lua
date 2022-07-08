local ok, gitsigns = pcall(require, "gitsigns")
if not ok then
  return
end

local config = {
  signs = {
    add = {
      hl = "GitSignsAdd",
      text = "▎",
      numhl = "GitSignsAddNr",
      linehl = "GitSignsAddLn",
    },
    change = {
      hl = "GitSignsChange",
      text = "▎",
      numhl = "GitSignsChangeNr",
      linehl = "GitSignsChangeLn",
    },
    delete = {
      hl = "GitSignsDelete",
      text = "契",
      numhl = "GitSignsDeleteNr",
      linehl = "GitSignsDeleteLn",
    },
    topdelete = {
      hl = "GitSignsDelete",
      text = "契",
      numhl = "GitSignsDeleteNr",
      linehl = "GitSignsDeleteLn",
    },
    changedelete = {
      hl = "GitSignsChange",
      text = "▎",
      numhl = "GitSignsChangeNr",
      linehl = "GitSignsChangeLn",
    },
  },
  numhl = false,
  linehl = false,
  keymaps = {
    -- Default keymap options
    noremap = true,
    buffer = true,
  },
  signcolumn = true,
  word_diff = false,
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter_opts = {
    relative_time = false,
  },
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = "rounded",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },
  sign_priority = 6,
  update_debounce = 200,
  status_formatter = nil, -- Use default
}

gitsigns.setup(config)

local setter = vim.keymap.set
local add = function(key, fun, desc)
  setter("n", key, fun, { desc = desc })
end

-- KEY: Gitsigns
-- <leader>gs is reserved for telescope git status
add("<leader>gh", gitsigns.stage_hunk, "Gitsigns Stage Hunk")

add("<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", { desc = "Gitsigns Diff" })
add("<leader>gj", gitsigns.next_hunk, { desc = "Gitsigns Next Hunk" })
add("<leader>gk", gitsigns.prev_hunk, "Gitsigns Prev Hunk")
add("<leader>gl", gitsigns.blame_line, "Gitsigns Blame Line")
add("<leader>gp", gitsigns.preview_hunk, "Gitsigns Preview Hunk")
add("<leader>gr", gitsigns.reset_hunk, "Gitsigns Reset Hunk")
add("<leader>gR", gitsigns.reset_buffer, "Gitsigns Reset Buffer")
add("<leader>gu", gitsigns.undo_stage_hunk, "Gitsigns Undo Stage Hunk")
