--[[ see scratch/lsp_installer_rethought.md --]]
local M = {}

-- nvim-lsp-installer, path.lua
local sep = "/"
local path = {
  concat = function(path_components)
    return table.concat(path_components, sep)
  end,
}

-- nvim-lsp-installer, settings.lua
local settings = {
  install_root_dir = vim.fn.stdpath "data" .. sep .. "lsp_servers",
}

-- nvim-lsp-installer, platform.lua
local platform = {
  path_sep = ":",
}

-- nvim-lsp-installer, process.lua
local initial_environ = vim.fn.environ()
local process = {

  ---@param new_paths string[] @A list of paths to prepend the existing PATH with.
  extend_path = function(new_paths)
    local new_path_str = table.concat(new_paths, platform.path_sep)
    return ("%s%s%s"):format(new_path_str, platform.path_sep, initial_environ.PATH or "")
  end,
}

-- not tested yet
M.cargo = {
  ---@param root_dir string The directory to resolve the executable from.
  env = function(root_dir)
    return {
      PATH = process.extend_path { path.concat { root_dir, "bin" } },
    }
  end,
}

-- npm module
M.npm = {
  env = function(dirname)
    return {
      PATH = process.extend_path { path.concat { settings.install_root_dir, dirname, "node_modules", ".bin" } },
    }
  end,
}

-- example: repo = "sumneko/vscode-lua",
-- the name "custom" is not from lsp_installer
M.custom = {
  env = function(dirname_table)
    local relative_path = path.concat(dirname_table)
    return {
      PATH = process.extend_path { path.concat { settings.install_root_dir, relative_path } },
    }
  end,
}

return M
