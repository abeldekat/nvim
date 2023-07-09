return {
  {
    "echasnovski/mini.files",
    opts = {
      mappings = {
        go_in = "L",
        go_in_plus = "l",
      },
      content = {
        filter = function(fs_entry)
          return not vim.startswith(fs_entry.name, ".")
        end,
      },
    },
    keys = {
      { -- Oil has key "mk", copy <leader>fm to "ml"
        "ml",
        function()
          require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
        end,
        desc = "Open mini.files (directory of current file)",
      },
    },
  },
}
