local ok, _ = pcall(require, "trouble")
if not ok then
  return
end

-- KEY: Diagnostics Trouble
vim.keymap.set("n", "<leader>dt", "<cmd>TroubleToggle<cr>", { desc = "Diagnostics Toggle Trouble" })
