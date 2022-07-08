-- TODO: Do I need a "match" plugin?
local g = vim.g

-- Disable some built-in plugins we don't want
g.loaded_gzip = 1
g.loaded_zip = 1
g.loaded_zipPlugin = 1
g.loaded_tar = 1
g.loaded_tarPlugin = 1

g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1

g.loaded_vimball = 1
g.loaded_vimballPlugin = 1
g.loaded_2html_plugin = 1
g.loaded_matchit = 1
g.loaded_matchparen = 1
g.loaded_logiPat = 1
g.loaded_rrhelper = 1
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.loaded_netrwSettings = 1

-- g.loaded_man = 1
-- g.loaded_remote_plugins = 1
g.loaded_shada_plugin = 1

-- disable ruby support
g.loaded_ruby_provider = 0
-- disable perl support
g.loaded_perl_provider = 0
-- vim.g.loaded_node_provider = 0
-- vim.g.python3_host_prog = '/usr/local/bin/python3'
