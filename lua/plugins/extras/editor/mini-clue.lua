-- TODO: test core +test
-- TODO: lang tex +vimtext
-- TODO: lang java Extract
-- TODO: dap core +debug +adapters
-- TODO: coding mini.ai operator pending mode, not encouraged

local autoload = true

return {
  {
    "folke/which-key.nvim", -- just prevent activation, as cond disables updating
    keys = function()
      return {}
    end,
    event = function()
      return {}
    end,
  },

  {
    "echasnovski/mini.clue",
    event = function()
      return autoload and { "VeryLazy" } or {}
    end,
    keys = function()
      -- stylua: ignore start
      return autoload and {}
        or {{ "<leader>mc", function() require("mini.clue") end, desc = "[C]lue" }}
      -- stylua: ignore end
    end,
    opts = function(_, _)
      local miniclue = require("mini.clue")

      local result = {
        window = {
          config = { width = "auto" },
          -- delay = 0,
        },

        triggers = {
          -- not encouraged:
          -- { mode = "o", keys = "i" },
          -- { mode = "o", keys = "a" },

          -- `[` key
          { mode = "n", keys = "[" },
          { mode = "x", keys = "[" },
          --
          -- `]` key
          { mode = "n", keys = "]" },
          { mode = "x", keys = "]" },

          -- Leader triggers
          { mode = "n", keys = "<Leader>" },
          { mode = "x", keys = "<Leader>" },

          -- Built-in completion
          { mode = "i", keys = "<C-x>" },

          -- `g` key
          { mode = "n", keys = "g" },
          { mode = "x", keys = "g" },

          -- Marks
          { mode = "n", keys = "'" },
          { mode = "n", keys = "`" },
          { mode = "x", keys = "'" },
          { mode = "x", keys = "`" },

          -- Registers
          { mode = "n", keys = '"' },
          { mode = "x", keys = '"' },
          { mode = "i", keys = "<C-r>" },
          { mode = "c", keys = "<C-r>" },

          -- Window commands
          { mode = "n", keys = "<C-w>" },

          -- `z` key
          { mode = "n", keys = "z" },
          { mode = "x", keys = "z" },
        },

        clues = { -- clues for triggers...
          miniclue.gen_clues.builtin_completion(),
          miniclue.gen_clues.g(),
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers({ show_contents = false }),
          miniclue.gen_clues.windows({
            submode_move = true, -- submode: move
            submode_navigate = false, -- using lazyvim's bindings
            submode_resize = false, -- using lazyvim's bindings
          }),
          miniclue.gen_clues.z(),

          { mode = "n", keys = "<leader><tab>", desc = "+tabs" },
          { mode = "n", keys = "<leader>b", desc = "+buffer" },
          { mode = "n", keys = "<leader>c", desc = "+code" },
          { mode = "n", keys = "<leader>d", desc = "+debug" },
          { mode = "n", keys = "<leader>f", desc = "+file/find" },
          { mode = "n", keys = "<leader>g", desc = "+git" },
          { mode = "n", keys = "<leader>gh", desc = "+hunks" },
          { mode = "n", keys = "<leader>m", desc = "+[M]isc" }, -- added
          -- ["<leader>q"] = { name = "+quit/session" }, -- removed from wk
          { mode = "n", keys = "<leader>s", desc = "+search" },
          { mode = "n", keys = "<leader>t", desc = "+test" },
          -- ["<leader>w"] = { name = "+windows" }, -- removed from wk
          { mode = "n", keys = "<leader>u", desc = "+ui" },
          { mode = "n", keys = "<leader>x", desc = "+diagnostics/quickfix" },
          { mode = "n", keys = "<leader>z", desc = "+[Z]urround" }, --replaces gz

          -- submode: buffer navigation
          { mode = "n", keys = "[b", postkeys = "[" },
          { mode = "n", keys = "]b", postkeys = "]" },
        },
      }

      if require("lazyvim.util").has("noice.nvim") then
        table.insert(result.clues, { mode = "n", keys = "<leader>sn", desc = "+noice" })
      end
      return result
    end,
  },
}
