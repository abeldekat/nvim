-- LazyVim supplies telescope integration:
-- mappings = { n = { s = flash }, i = { ["<c-s>"] = flash }, },
return {
  {
    "folke/flash.nvim",
    -- keys = { -- match on start of word
    --   {
    --     "s",
    --     mode = { "n", "x", "o" },
    --     function()
    --       require("flash").jump({
    --         search = { -- start of word
    --           mode = function(str)
    --             return "\\<" .. str
    --           end,
    --         },
    --       })
    --     end,
    --     desc = "Flash",
    --   },
    -- },
    opts = {
      search = {
        multi_window = true, -- default
      },
      label = {
        uppercase = true, --default
      },
      modes = {
        char = {
          enabled = false,
          -- hide after jump when not using jump labels
          autohide = false, -- default
          -- show jump labels
          jump_labels = true, -- default
        },
      },
    },
  },
}
