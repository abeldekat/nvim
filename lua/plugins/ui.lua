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
  { "echasnovski/mini.indentscope", enabled = false, event = dummy_function },
  { "akinsho/bufferline.nvim", enabled = false, keys = dummy_function, event = dummy_function },
  { "rcarriga/nvim-notify", enabled = false, init = dummy_function, keys = dummy_function },
  { "folke/noice.nvim", enabled = false, keys = dummy_function, event = dummy_function},
  { "SmiteshP/nvim-navic", enabled = false },
  -- stylua: ignore end

  -- ---------------------------------------------
  -- overriding ....
  -- ---------------------------------------------
  { -- adding "[i", "]i", replacing mini.indentscope
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
          lualine_c = { { "filename", path = 1, shortening_target = 40 } },
        },
      }
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
