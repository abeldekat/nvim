=== nvim-lsp-installer: 
It is possible to only use this plugin for installing lsp servers.
The plugin can be optional, lsp installation can be done by packadd nvim-lsp-installer followed by LspInstall
In order to use the resulting servers without using nvim-lsp-installer,
lspconfig needs a proper cwd_env configured.
This module copied and simplified the necessary code from modules in nvim-lsp-installer

See installers package
Also see: local INSTALL_DIRS, in servers/init.lua

example output from nvim-lsp-installer, server.lua, function M.Server:setup_lsp:
...
cmd_env = {
 PATH = "/home/username/.local/share/nvim/lsp_servers/jsonls/node_modules/.bin:/home/username/.local/bin:/home/username/.cargo/bin:/home/username/bin/scripts/utils:/home/username/bin/scripts/colors:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/var/lib/snapd/snap/bin"
},
on_attach = <function 1>
...

=== important links:
feat: integrate with lspconfig's on_setup hook #631:
https://github.com/williamboman/nvim-lsp-installer/pull/631,
==> it is mentioned that there are exceptions, for example angular...
==> the mentioned scratch/examples/minimal_lsp.lua is useful


-- sumneko nvim-lsp-installer:
--[[
default_options = {
    cmd_env = {
        PATH = process.extend_path {
            path.concat { root_dir, "extension", "server", "bin" },
        },
    },
},
--]]

-- jsonls nvim-lsp-installer:
--[[
default_options = {
    cmd_env = npm.env(root_dir),
},
--]]

