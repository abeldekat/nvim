--[[
  autocmd BufEnter *   lua require('lir').init()
  lir.init, after mappings applied:
  a.nvim_buf_set_option(0, "filetype", "lir")

  Attach shorthand keymappings when using lir:
--]]

local ok, _ = pcall(require, "lir")
if not ok then
  return
end

local ak_lir = vim.api.nvim_create_augroup("ak_lir", {})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lir",
  callback = function()
    --
    vim.keymap.set("n", "d", function()
      require "ak.telescope.custom.directories"()
    end, { buffer = 0, silent = true, nowait = true, desc = "Telescope directories" })
    --
    vim.keymap.set("n", "y", function()
      require "ak.telescope.custom.fnamemodify_lir"()
    end, {
      buffer = 0,
      silent = true,
      nowait = true,
      desc = "Telescope choose path variants to yank when using lir",
    })
  end,
  group = ak_lir,
})
