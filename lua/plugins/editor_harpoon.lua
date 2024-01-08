-- TODO: The example: "<C-S-P>" ctrl shifht p?
return {
  {
    "ThePrimeagen/harpoon",
    lazy = false,
    branch = "harpoon2",
    config = function(_, opts)
      local harpoon = require("harpoon") --> returns obj "the_harpoon"
      harpoon:setup({}) -- object call, instead of .setup. No default config support
    end,
    keys = function()
      local function append()
        require("harpoon"):list():append()
      end
      local function ui()
        require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
      end
      local function select(index)
        require("harpoon"):list():select(index)
      end
      local function prev()
        require("harpoon"):list():prev()
      end
      local function next()
        require("harpoon"):list():next()
      end
      -- local function to_terminal()
      --   local num = tonumber(vim.fn.input("Terminal window number: "))
      --   require("harpoon.term").gotoTerminal(num)
      -- end

      -- stylua: ignore
      return {
        { "<leader>h", append, desc = "[H]arpoon append" },
        { "<leader>j", ui, desc = "Harpoon ui" },
        { "<leader>n", next, desc = "Harpoon [n]ext" },
        { "<leader>p", prev, desc = "Harpoon [p]rev" },
        -- { "<leader>fh", to_terminal, desc = "[H]arpoon terminal" },
        { "<c-j>", function() select(1) end, desc = "Harpoon 1" },
        { "<c-k>", function() select(2) end, desc = "Harpoon 2" },
        { "<c-l>", function() select(3) end, desc = "Harpoon 3" },
        { "<c-h>", function() select(4) end, desc = "Harpoon 4" },
      }
    end,
  },
}
