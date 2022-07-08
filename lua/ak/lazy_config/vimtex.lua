-- taken from mathjiajia
-- local custom_cmds = {
--   { name = "longrightarrow", mathmode = 1, concealchar = "→", opt = false, arg = false },
--   { name = "dashrightarrow", mathmode = 1, concealchar = "⇢", opt = false, arg = false },
--   { name = "ar", mathmode = 1, concealchar = "→", opt = true, arg = true },
-- }

-- vim.g.vimtex_quickfix_mode = 2
-- -- vim.g.vimtex_view_method = "skim"
-- vim.g.vimtex_syntax_custom_cmds = custom_cmds

-- abccoding
-- vim.g.vimtex_compiler_method = "latexmk"
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_fold_enabled = 0
vim.g.vimtex_quickfix_ignore_filters = {}
vim.cmd [[
      augroup vimtex_event_1
          au!
          au User VimtexEventQuit     call vimtex#compiler#clean(0)
          au User VimtexEventInitPost call vimtex#compiler#compile()
      augroup END
  ]]
