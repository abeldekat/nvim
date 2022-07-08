local disable = {
  impatient = false,
  fixcursorhold = false,
  plenary = false,
}
local result = {
  { "lewis6991/impatient.nvim", disable = disable.impatient },

  { "nvim-lua/plenary.nvim", disable = disable.plenary },

  -- https://github.com/neovim/neovim/issues/12587,  -- CursorHold and CursorHoldI autocmd events performance bug {
  {
    "antoinemadec/FixCursorHold.nvim",
    disable = disable.fixcursorhold,
    -- run = function()
    --   vim.g.curshold_updatime = 1000
    -- end,
  },
}

return result
