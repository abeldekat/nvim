-- TODO:
-- builtin.current_buffer_fuzzy_find() builtin.tags()
-- require('telescope').extensions.bibtex.bibtex {}
-- require("telescope").extensions.file_browser.file_browser {}
-- require("telescope").extensions.frecency.frecency {}

-- telescope can be lazy loaded
local name = "telescope.nvim"
local optional_installs = require "ak.core.optional_installs"
if not optional_installs.is_installed(name, "telescope") then
  return
end

-- telescope key mappings to custom functions
-- safe to lazy load:
require "ak.telescope.internal.files"
require "ak.telescope.internal.search"
require "ak.telescope.internal.git"
require "ak.telescope.internal.neovim"
require "ak.telescope.internal.diagnostics"
require "ak.telescope.internal.lsp"
require "ak.telescope.internal.project_nvim"
require "ak.telescope.internal.lir"
require "ak.telescope.internal.dap"
