vim.g.db_ui_use_nerd_fonts = 1
return {
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
  { -- cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    "kristijanhusak/vim-dadbod-ui",
    -- In local .lazy.lua:
    -- init = function() vim.g.dbs = { dev = "mysql://user:password@db-name", } end,
    dependencies = {
      { "tpope/vim-dadbod" },
      { "kristijanhusak/vim-dadbod-completion" },
    },
    -- stylua: ignore
    keys = { { "<leader>cu", function() vim.cmd("DBUIToggle") end, desc = "Dadbod [U]I" } },
    config = function()
      -- local filepath = vim.fn.fnamemodify(".lazy.lua", ":p")
      -- let g:db_ui_save_location = '~/Dropbox/db_ui_queries'

      vim.g.db_ui_show_help = 0
      vim.g.db_ui_execute_on_save = 0

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "mysql", "plsql" },
        callback = function()
          vim.bo.filetype = "sql" -- mysql: no treesitter, no comments, see issue 65
        end,
      })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "sql" },
        callback = function()
          vim.keymap.set(
            { "n", "v" },
            "mq", -- leader S is not that practical
            "<Plug>(DBUI_ExecuteQuery)",
            { desc = "Execute Query", silent = true, buffer = true, nowait = true }
          )
          ---@diagnostic disable-next-line: missing-fields
          require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
        end,
      })
    end,
  },
}
