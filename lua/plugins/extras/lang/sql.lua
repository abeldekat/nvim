return {

  -- {
  --   "kristijanhusak/vim-dadbod-ui",
  --   -- In local .lazy.lua:
  --   -- vim.g.dbs = { dev = "mysql://user:password@db-name", } end,
  --   dependencies = {
  --     { "tpope/vim-dadbod" },
  --     { "kristijanhusak/vim-dadbod-completion" },
  --   },
  --   cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
  --   -- stylua: ignore
  --   keys = { { "<leader>cu", function() vim.cmd("DBUIToggle") end, desc = "Dadbod [U]I" } },
  --   init = function() vim.g.db_ui_use_nerd_fonts = 1 end,
  --   config = function()
  --     -- let g:db_ui_save_location = '~/Dropbox/db_ui_queries'
  --     vim.g.db_ui_show_help = 0
  --     vim.g.db_ui_execute_on_save = 0
  --
  --     vim.api.nvim_create_autocmd("FileType", {
  --       pattern = { "sql", "mysql", "plsql" },
  --       callback = function()
  --         vim.keymap.set(
  --           { "n", "v" },
  --           "mq", -- leader S is not that practical
  --           "<Plug>(DBUI_ExecuteQuery)",
  --           { desc = "Execute Query", silent = true, buffer = true, nowait = true }
  --         )
  --         ---@diagnostic disable-next-line: missing-fields
  --         require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
  --       end,
  --     })
  --   end,
  -- }

  {
    "nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "sql",
      })
    end,
  },

  {
    "mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "sql-formatter" })
    end,
  },

  {
    "conform.nvim",
    opts = { formatters_by_ft = { sql = { "sql-formatter" } } },
  },

  -- dadbod-ui and mysql: ft hardcoded to "mysql", breaking treesitter and comment
  -- use dadbod for autocompletion, combine with vim-slime and mysql cli
  -- in .envrc construct $DATABASE_URL
  -- or in .lazy.lua: w:db b:db g:db
  {
    "tpope/vim-dadbod",
    keys = function() -- trigger using keys when ft = sql
      local function send_paragraph()
        vim.cmd('norm! "xyip')
        vim.cmd("silent! DB " .. vim.fn.getreg("x")) -- <cmd>silent! %DB<cr>
      end
      return {
        -- execute a query without vim-slime and the mysql cli:
        { "mq", send_paragraph, ft = "sql", desc = "Run sql in paragraph" },
        -- stylua: ignore
        { "<leader>md", function() vim.print("Loaded dadbod") end, ft = "sql", desc = "Load dadbod" },
      }
    end,
    dependencies = { "kristijanhusak/vim-dadbod-completion" },
    config = function()
      local function cmp()
        require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
      end
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "sql" },
        callback = cmp,
      })

      vim.cmd("DBCompletionClearCache") -- current buffer completion
      cmp()
    end,
  },
}
