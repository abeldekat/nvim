local t = { "a", "b" }
table.insert(t, "c")
table.insert(t, "d")
P(t)
vim.api.nvim_echo({ { string.format("Packer about to load %s", vim.inspect(t)) } }, false, {})
