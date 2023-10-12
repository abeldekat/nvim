return {
  -- ---------------------------------------------
  -- observing ....
  -- ---------------------------------------------

  -- ---------------------------------------------
  -- disabling ....
  -- ---------------------------------------------
  { "echasnovski/mini.indentscope", enabled = false },
  { "akinsho/bufferline.nvim", enabled = false },
  { "rcarriga/nvim-notify", enabled = false },
  { "folke/noice.nvim", enabled = false },

  -- ---------------------------------------------
  -- overriding ....
  -- ---------------------------------------------

  { -- highlight the scope where variables and functions are accessible
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      scope = {
        enabled = true,
        show_start = false,
        show_end = false,
        include = {
          node_type = { lua = { "return_statement", "table_constructor" } },
        },
      },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, _)
      return {
        options = {
          icons_enabled = false,
          globalstatus = true,
          component_separators = "|",
          section_separators = "",
          disabled_filetypes = { statusline = { "dashboard", "alpha" } },
        },
        sections = {
          lualine_c = { { "filename", path = 1, shortening_target = 40, symbols = { unnamed = "" } } },
        },
      }
    end,
  },

  -- TODO: v10.0
  -- {
  --   "goolord/alpha-nvim",
  --   event = function()
  --     local should_load = function()
  --       -- don't start when opening a file
  --       if vim.fn.argc() > 0 then
  --         return false
  --       end
  --       -- ... more logic here
  --       return true
  --     end
  --
  --     if should_load() then
  --       return { "VimEnter" }
  --     else
  --       return {}
  --     end
  --   end,
  --   opts = function(_, opts)
  --     local versioninfo = vim.version() or {}
  --     local major = versioninfo.major or ""
  --     local minor = versioninfo.minor or ""
  --     local patch = versioninfo.patch or ""
  --     local prerelease = versioninfo.api_prerelease and "-dev" or ""
  --     local header = string.format("NVIM v%s.%s.%s%s", major, minor, patch, prerelease)
  --
  --     -- opts.section.header.val = vim.split(header, "\n")
  --     opts.section.header.val = header
  --     return opts
  --   end,
  -- },

  -- ---------------------------------------------
  -- adding ....
  -- ---------------------------------------------
  -- replacing noice, lsp feedback
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "LspAttach",
    opts = {
      text = {
        spinner = "dots", -- "grow_vertical",
      },
      window = {
        blend = 10,
      },
      fmt = {
        stack_upwards = true,
      },
      timer = {
        spinner_rate = 1000, --125,
        fidget_decay = 100, -- 2000 after all tasks have been completed
        task_decay = 100, -- 1000
      },
      sources = {
        ["null-ls"] = {
          ignore = true,
        },
      },
    },
  },
}
