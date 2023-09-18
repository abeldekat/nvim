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
  { "echasnovski/mini.ai", enabled = false, event = dummy_function }, -- see treesitter.lua
  { "echasnovski/mini.comment", enabled = false, event = dummy_function },
  { "echasnovski/mini.pairs", enabled = false, event = dummy_function },
  -- performance: empty the keys to be generated in super.keys:
  { "echasnovski/mini.surround", enabled = false, opts = function() return { mappings = {} } end},
  -- stylua: ignore end

  -- ---------------------------------------------
  -- overriding ....
  -- ---------------------------------------------

  -- ---------------------------------------------
  -- adding ....
  -- ---------------------------------------------

  { -- replacing mini.comment(VeryLazy):
    "numToStr/Comment.nvim",
    keys = {
      { "gc", mode = { "n", "v" }, desc = "Comment toggle linewise" },
      { "gb", mode = { "n", "v" }, desc = "Comment toggle blockwise" },
    },
    opts = function()
      local commentstring_avail, commentstring = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
      return commentstring_avail and commentstring and { pre_hook = commentstring.create_pre_hook() } or {}
    end,
  },

  { -- replacing mini.pairs
    -- note: insertmode, press C-v, the character will not be paired
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
      ts_config = { java = false },
      fast_wrap = {
        map = "<M-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
        offset = 0,
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "PmenuSel",
        highlight_grey = "LineNr",
      },
    },
    config = function(_, opts)
      local npairs = require("nvim-autopairs")
      npairs.setup(opts)

      local cmp_status_ok, cmp = pcall(require, "cmp")
      if cmp_status_ok then
        cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done({ tex = false }))
      end
    end,
  },

  -- replacing mini.surround:
  -- curly square round angle...
  -- B {}, curly [B]rackets, braces, bretels, braces programming
  -- r [], squa[r]e brackets, brackets[US]
  -- b (), [b]rackets[UK], round brackets, parenthesis, parens
  -- a <>, [a]ngle brackets, chevrons(v shape)
  --
  -- tabular aliases, only when modifying existing, the nearest such pair:
  -- q, quotes { '"', "'", "`" },
  -- s, symbols: brackets and quotes { "}", "]", ")", ">", '"', "'", "`" },
  -- Note: Tabular aliases cannot be used to add surrounding pairs, e.g. `ysa)q` is
  -- invalid, since it's ambiguous which pair should be added.
  --
  -- jumping preference
  -- * pairs that surround the cursor, before
  -- * pairs that occur after the cursor, before
  -- * pairs that occur before the cursor.
  {
    "kylechui/nvim-surround",
    version = "*",
    init = function()
      -- b and B are valid vim motions already:
      vim.keymap.set("o", "ir", "i[")
      vim.keymap.set("o", "ar", "a[")
      vim.keymap.set("o", "ia", "i<")
      vim.keymap.set("o", "aa", "a<")
    end,
    keys = { -- switch to capital: "surrounding pair on new line"

      -- insert: pairs-like behavior. Surround with any char
      { "<C-g>z", desc = "Add a surrounding pair around the cursor (insert mode)", mode = { "i" } },
      -- insert_line
      { "<C-g>Z", desc = "Add a surrounding pair around the cursor, on new lines (insert mode)", mode = { "i" } },

      -- normal
      { "yz", desc = "Add a surrounding pair around a motion (normal mode)" },
      -- normal_cur
      { "yzz", desc = "Add a surrounding pair around the current line (normal mode)" },
      -- normal_line
      { "yZ", desc = "Add a surrounding pair around a motion, on new lines (normal mode)" },
      -- normal_cur_line
      { "yZZ", desc = "Add a surrounding pair around the current line, on new lines (normal mode)" },

      -- visual
      { "Z", desc = "Add a surrounding pair around a visual selection", mode = { "x" } },
      -- visual_line
      { "gZ", desc = "Add a surrounding pair around a visual selection, on new lines", mode = { "x" } },

      -- change
      { "dz", desc = "Delete a surrounding pair" },
      -- delete
      { "cz", desc = "Change a surrounding pair" },
      { "cZ", desc = "Change a surrounding pair, on new lines" },
    },
    opts = {
      keymaps = {
        insert = "<C-g>z",
        insert_line = "<C-g>Z",
        normal = "yz",
        normal_cur = "yzz",
        normal_line = "yZ",
        normal_cur_line = "yZZ",
        visual = "Z",
        visual_line = "gZ",
        delete = "dz",
        change = "cz",
        change_line = "cZ",
      },
    },
  },

  { -- cr: replace, gx: exchange, g=:evaluate, gm: multiply, gs: sort
    -- multiply: overrides half a screen width to the right
    -- sort: overrides go sleep
    -- exchange: overrides netrw mapping
    "echasnovski/mini.operators",
    event = "VeryLazy",
    opts = {
      replace = { prefix = "cr" }, -- lsp: gr is taken...
    },
  },
}
