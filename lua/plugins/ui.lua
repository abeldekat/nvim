local dummy_function = function()
  return {}
end

return {
  -- ---------------------------------------------
  -- observing ....
  -- ---------------------------------------------

  -- ---------------------------------------------
  -- disabling ....
  -- ---------------------------------------------
  -- stylua: ignore start
  { "akinsho/bufferline.nvim", enabled = false, keys = dummy_function, event = dummy_function },
  { "rcarriga/nvim-notify", enabled = false, keys = dummy_function },
  { "echasnovski/mini.indentscope", enabled = false, event = dummy_function },
  -- stylua: ignore end

  -- ---------------------------------------------
  -- overriding ....
  -- ---------------------------------------------
  { -- adds "[i", "]i", replacing mini.indentscope
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      -- replacing mini.indentscope:
      -- note: use other textobjects for ii/ai, example: viB
      show_current_context = true,
      show_current_context_start = false,
    },
    config = function(_, opts)
      local function current_context()
        return require("indent_blankline.utils").get_current_context(
          vim.g.indent_blankline_context_patterns,
          vim.g.indent_blankline_use_treesitter_scope
        )
      end
      local function add_go_to_indent_scope_key(context_callback, keymap, desc)
        vim.keymap.set({ "n", "x" }, keymap, function() -- nvchad
          local ok, move_to = context_callback()
          if ok then
            vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { move_to, 0 })
            vim.cmd([[normal! _]])
          end
        end, { desc = desc })
      end

      require("indent_blankline").setup(opts)
      add_go_to_indent_scope_key(function()
        local ok, node_start = current_context()
        return ok, node_start
      end, "[i", "Go to indent scope top")
      add_go_to_indent_scope_key(function()
        local ok, _, node_end = current_context()
        return ok, node_end
      end, "]i", "Go to indent scope bottom")
    end,
  },

  {
    "folke/noice.nvim",
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
      -- opts.extensions = {} -- peformance? Loads devicons...
      --
      return opts
    end,
  },

  {
    "goolord/alpha-nvim",
    event = function()
      local should_load = function()
        -- don't start when opening a file
        if vim.fn.argc() > 0 then
          return false
        end
        -- ... more logic here
        return true
      end

      if should_load() then
        return { "VimEnter" }
      else
        return {}
      end
    end,
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

  -- { -- using mini-hipatterns:
  --   "norcalli/nvim-colorizer.lua",
  --   keys = {
  --     { "<leader>uz", mode = { "n" }, "<cmd>ColorizerToggle<cr>", desc = { "Toggle Colorizer" },},
  --   },
  --   config = true,
  -- },
}
