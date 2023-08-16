return {
  -- ---------------------------------------------
  -- observing ....
  -- ---------------------------------------------
  -- NOTE: mini.indentscope, in ui:
  -- augments indent_blankline with current indent
  -- also creates textobjects: The "i" object scope
  -- [i: goto top, ]i goto bottom

  -- ---------------------------------------------
  -- disabling ....
  -- ---------------------------------------------
  -- always disabled:
  { "akinsho/bufferline.nvim", enabled = false },
  -- testing:
  -- { "stevearc/dressing.nvim", enabled = false },
  -- { "rcarriga/nvim-notify", enabled = false },
  --
  -- { "echasnovski/mini.indentscope", enabled = false },
  -- { "lukas-reineke/indent-blankline.nvim", enabled = false },

  -- ---------------------------------------------
  -- overriding ....
  -- ---------------------------------------------
  {
    "folke/noice.nvim",
    -- enabled = false,
    keys = {
      { "<S-Enter>", false, mode = "c" }, -- does not trigger, change to alt
      {
        "<A-CR>",
        function()
          require("noice").redirect(vim.fn.getcmdline())
        end,
        mode = "c",
        desc = "Redirect Cmdline",
      },
    },
    opts = function(_, opts)
      opts["views"] = { -- LazyVim has no views section
        split = { enter = true },
      }
      opts["messages"] = { -- LazyVim has no messages section
        view_search = false,
      }
      local routes = {
        { filter = { event = "msg_show", find = "Hunk %d of %d" }, view = "mini" },
        { filter = { event = "notify", find = "Config Change Detected." }, opts = { skip = true } },
        { filter = { event = "notify", min_height = 5 }, view = "split" },
      }
      opts["routes"] = vim.list_extend(routes, opts["routes"])

      -- opts.presets.cmdline_output_to_split = true -- Default false, always to split
      opts.presets.long_message_to_split = { -- LazyVim: true, on 20 lines, override
        routes = {
          { filter = { event = "msg_show", min_height = 5 }, view = "cmdline_output" },
        },
      }
      opts.presets.lsp_doc_border = true
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options = vim.tbl_deep_extend("force", opts.options, {
        component_separators = "::",
        section_separators = "",
      })
      opts.sections.lualine_c = vim.tbl_filter(function(comp)
        if comp[1] == "filename" then
          comp.path = 1
          comp.shortening_target = 40
        end
        return comp
      end, opts.sections.lualine_c)
      table.insert(opts.sections.lualine_x, "encoding")
      opts.sections.lualine_y = { "progress" } -- default lualine
      opts.sections.lualine_z = { "location" } -- default lualine
      -- opts.extensions = {} -- this costs peformance? Loads devicons...
      --
      return opts
    end,
  },

  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      local versioninfo = vim.version() or {}
      local major = versioninfo.major or ""
      local minor = versioninfo.minor or ""
      local patch = versioninfo.patch or ""
      local prerelease = versioninfo.api_prerelease and "-dev" or ""
      local header = string.format("NVIM v%s.%s.%s%s", major, minor, patch, prerelease)

      -- opts.section.header.val = vim.split(header, "\n")
      opts.section.header.val = header
      return opts
    end,
  },

  -- ---------------------------------------------
  -- adding ....
  -- ---------------------------------------------

  -- { -- also deprecated, maybe move to https://gitlab.com/HiPhish/rainbow-delimiters.nvim
  --   "nvim-treesitter/nvim-treesitter",
  --   dependencies = { "HiPhish/rainbow-delimiters.nvim" },
  --   opts = function(_, opts)
  --     opts.rainbow = {
  --       enable = true,
  --       query = "rainbow-delimiters",
  --       strategy = require("rainbow-delimiters").strategy.global,
  --     }
  --   end,
  -- },

  -- { -- using mini-hipatterns:
  --   "norcalli/nvim-colorizer.lua",
  --   keys = {
  --     {
  --       "<leader>uz",
  --       mode = { "n" },
  --       "<cmd>ColorizerToggle<cr>",
  --       desc = { "Toggle Colorizer" },
  --     },
  --   },
  --   config = true,
  -- },
}
