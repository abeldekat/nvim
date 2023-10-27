--[[
https://github.com/LazyVim/LazyVim/pull/1031 add python support

"
I've simply resorted to installing debugpy in each project of mine. Not great, but the only way I got this to work reliably.
"

https://github.com/williamboman/mason.nvim/blob/main/doc/reference.md#packageget_install_path:

"
Returns: string The full path where this package is installed.
Note that this will always return a string, regardless of whether the package is actually installed or not.
"
--]]
return {

  -- Ensure Python debugger is installed
  {
    "williamboman/mason.nvim",
    optional = true,
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        if require("lazyvim.util").has("nvim-dap") then
          vim.list_extend(opts.ensure_installed, { "debugpy" })
        end
      end
    end,
  },
}
