=== Remove lsp installer refactoring
-- first commit: nvim-lsp-installer removal: Cleanup, keep enabled only for sumneko_lua
-- second commit: working without lsp installer for sumneko_lua
-- TODO: have a look at nlsp-settings
-- TODO: compare buffermappings with website example

--> gain: 15 ms

https://github.com/neovim/nvim-lspconfig:
"
For a full list of servers, see server_configurations.md or :help lspconfig-server-configurations. This document contains installation instructions and additional, optional, customization suggestions for each language server. For some servers that are not on your system path (e.g., jdtls, elixirls), you will be required to manually add cmd as an entry in the table passed to setup. Most language servers can be installed in less than a minute.
"

To install, install notes are in lua/ak/lsp/client/: 
sumneko_lua
vimls
bashls
awk.ls, 
pyright
texlab
lemminx for xml xsd xsl xslt
yamlls
jsonls

Interesting:
clangd for c
cmake
ccsls
dockerls
gopls
groovyls
hls for haskell
html
jdtls
tsserver
rnix
perlnavigator
intelephense for php
solargraph for ruby
rust_analyzer
bashls
taplo for toml  
