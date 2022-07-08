--[[
all buffer mappings and other settings regarding lsp are created in ak/lsp
null-ls can only format if the primary lsp in ak/lsp is configured to opt out of formatting...

all null-ls sources are able to hook into the following LSP features:
Code actions Diagnostics (file- and project-level) Formatting (including range formatting) Hover Completion
]]

local ok, null_ls = pcall(require, "null-ls")
if not ok then
  return
end

-- register at least one source ...
null_ls.setup {
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.shfmt,
    -- shellharden does not format style:
    null_ls.builtins.formatting.shellharden,
    -- null_ls.builtins.formatting.black,
    -- null_ls.builtins.diagnostics.flake8,
    null_ls.builtins.diagnostics.shellcheck,
    -- null_ls.builtins.completion.spell,
  },
}

-- KEY: null-ls
vim.keymap.set("n", "<leader>ln", "<cmd>NullLsInfo<cr>", { desc = "LSP null-ls info" })

--[[
  https://github.com/johnnymorganz/stylua
  An opinionated code formatter for Lua 5.1, Lua 5.2 and Luau,
  built using full-moon. StyLua is inspired by the likes of prettier,
  it parses your Lua codebase, and prints it back out from scratch,
  enforcing a consistent code style.

  You can create a .styluaignore file, with a format similar to .gitignore.
  Any files matching the globs in the ignore file will be ignored by StyLua. For example, for a .styluaignore file with the following contents:

  If there is a specific statement within your file which you wish to skip formatting on, you can precede it with -- stylua: ignore, and it will be skipped over during formatting.
  This may be useful when there is a specific formatting style you wish to preserve for a statement. For example:

  You can also disable formatting over a block of code by using -- stylua: ignore start / -- stylua: ignore end respectively.

  If you only want to format a specific range within a file, you can pass the --range-start <num> and/or --range-end <num> arguments,
  and only statements within the provided range will be formatted, with the rest ignored.

  Default stylua.toml:
column_width = 120
line_endings = "Unix"
indent_type = "Tabs"
indent_width = 4
quote_style = "AutoPreferDouble"
no_call_parentheses = false
]]
