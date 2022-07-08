local ok, navigator = pcall(require, "Navigator")
if not ok then
  return
end

navigator.setup()

local setter = vim.keymap.set
-- KEY: Window navigation including tmux
setter("n", "<C-h>", navigator.left, { desc = "Tmux Navigator Window Left" })
setter("n", "<C-k>", navigator.up, { desc = "Tmux Navigator Window Up" })
setter("n", "<C-l>", navigator.right, { desc = "Tmux Navigator Window Right" })
setter("n", "<C-j>", navigator.down, { desc = "Tmux Navigator Window Down" })
