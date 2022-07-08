local handlers = require "ak.lsp.handlers"
local lua_vimruntime = vim.fn.expand "$VIMRUNTIME/lua"

local opts = {
  capabilities = handlers.capabilities(),
  on_attach = function(client, bufnr)
    handlers.on_attach(client, bufnr)
    handlers.on_attach_formatting_opt_out(client, bufnr)
  end,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      -- does not prevent having to choose between nullls and sumneko
      -- does prevent formatting when sumneko is the only formatter
      format = {
        enable = true,
      },
      workspace = {
        library = {
          [lua_vimruntime] = true,
          -- [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          [vim.fn.stdpath "config" .. "/lua"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}

local lua_dev_loaded, lua_dev = pcall(require, "lua-dev")
if not lua_dev_loaded then
  return opts
end

local dev_opts = {
  library = {
    vimruntime = true, -- runtime path
    types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others

    -- plugins = true, -- installed opt or start plugins in packpath
    -- or list of plugins to make available as a workspace library
    plugins = { "plenary.nvim", "lua-dev.nvim", "telescope.nvim", "nvim-treesitter" },
  },
  -- runtime_path = true, -- enable this to get completion in require strings. Slow!
  lspconfig = opts,
}

return lua_dev.setup(dev_opts)

--[[
From lsp installer:
downloads from github, https://github.com/sumneko/vscode-lua/releases
-- The directory in which to install all servers.
install_root_dir = path.concat { vim.fn.stdpath "data", "lsp_servers" },

default_options = {
    cmd_env = {
        PATH = process.extend_path {
            path.concat { root_dir, "extension", "server", "bin" },
        },
    },
},
From lsp config:
    cmd = { 'lua-language-server' },
--]]
