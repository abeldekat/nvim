-- stylua: ignore start
-- if true then return {} end
-- stylua: ignore end
--
local spec = { -- the default when not invoked by the browser addon
  "glacambre/firenvim",
  build = function()
    vim.fn["firenvim#install"](0)
  end,
  module = false, -- prevent other code to require("firenvim")
  lazy = true, -- never load, except when lazy.nvim is building the plugin
}

if vim.g.started_by_firenvim == true then -- set by the browser addon
  spec = {
    { "noice.nvim", cond = false }, -- can't work with gui having ext_cmdline
    { "lualine.nvim", cond = false }, -- not useful in the browser
    vim.tbl_extend("force", spec, {
      lazy = false, -- must load at start in browser
      opts = {
        localSettings = {
          [".*"] = {
            -- on github, markdown editor, ctrl-e is taken. Use ctrl-6
            takeover = "never", -- security: activate with ctrl-e
            cmdline = "neovim", -- "firenvim"
          },
        },
      },
      config = function(_, opts)
        -- without lualine: vim.o.laststatus = 0
        -- vim.o.laststatus = 2 -- takes another screen line
        if type(opts) == "table" and (opts.localSettings or opts.globalSettings) then
          vim.g.firenvim_config = opts
        end
      end,
    }),
  }
end
return spec
