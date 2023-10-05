return {
  -- ---------------------------------------------
  -- observing ....
  -- ---------------------------------------------

  -- ---------------------------------------------
  -- disabling ....
  -- ---------------------------------------------
  { "echasnovski/mini.ai", enabled = false },
  { "echasnovski/mini.comment", enabled = false },
  { "echasnovski/mini.pairs", enabled = false },
  { "echasnovski/mini.surround", enabled = false },

  -- ---------------------------------------------
  -- overriding ....
  -- ---------------------------------------------

  -- ---------------------------------------------
  -- adding ....
  -- ---------------------------------------------

  { -- replacing mini.comment(VeryLazy):
    "numToStr/Comment.nvim", --astronvim
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
    "windwp/nvim-autopairs", -- astronvim
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

  { -- replacing mini.ai, also providing ii/ai textobjects
    -- NOTE: WIP

    --> subWord aS/iS, camelcase, _,-,.
    --> lineCharacterwise i_,a_, current line characterwise
    --> entireBuffer gG

    --> indentation ii ai iI aI
    --> restOfIndentation R
    --> restOfParagraph r, like }, but linewise
    --
    -- toNextClosingBracket C
    -- toNextQuotationMark Q
    -- column |, column down until indent

    -- found in subversive:
    -- " ie = inner entire buffer
    -- onoremap ie :exec "normal! ggVG"<cr>

    -- " iv = current viewable text in the buffer
    -- onoremap iv :exec "normal! HVL"<cr>
    "chrisgrieser/nvim-various-textobjs",
    event = { "BufReadPost", "BufNewFile" },
    -- event = "InsertEnter",
    opts = {
      useDefaultKeymaps = true,
      disabledKeymaps = {
        -- overrides next search result:
        "n", -- nearEol, from cursor to end of line minus one
        -- not that useful
        "ag", -- greedyOuterIndentation ag/ig
        "ig",
      },
    },
  },

  -- replacing mini.surround:
  -- b (), round brackets, [b]rackets(UK), parenthesis, parens
  -- B {}, curly [B]rackets, braces, bretels, "braces programming"
  -- a <>, [a]ngle brackets, chevrons(v shape)
  -- r [], squa[r]e brackets, brackets[US]
  --
  -- tabular aliases, only when modifying existing, the nearest such pair:
  -- q, quotes { '"', "'", "`" },
  -- s, symbols: brackets and quotes { "}", "]", ")", ">", '"', "'", "`" },
  -- Note: Tabular aliases cannot be used to add surrounding pairs, e.g. `ysa)q` is
  -- invalid, since it's ambiguous which pair should be added.
  --
  --  Invalid keys are accepted: "di ", deletes the word surrounded by spaces
  --
  -- jumping preference
  -- * pairs that surround the cursor, before
  -- * pairs that occur after the cursor, before
  -- * pairs that occur before the cursor.
  {
    "kylechui/nvim-surround",
    version = "*",
    -- init = function()
    --   -- b and B are valid vim motions already
    --   -- add a/i to angle and square aliases
    --   vim.keymap.set("o", "ia", "i<") -- treesitter [a]rgument
    --   vim.keymap.set("o", "aa", "a<")
    --   vim.keymap.set("o", "ir", "i[")
    --   vim.keymap.set("o", "ar", "a[")
    -- end,
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
      -- indent_lines = false
      -- move_cursor = false
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

  { -- substitute(aka replace): svermeulen/vim-subversive.
    -- exchange: tommcdo/vim-exchange
    -- alternative: mini.operators
    --
    -- Subversive: undermine, overthrow, overturn
    -- Abolish: to end an activity or custom
    -- it's possible to specify the register
    -- integrations, ie abolish
    --
    -- substitute gs: overrides go sleep
    -- exchange gx: overrides netrw mapping
    -- range gm: range, overrides half a screen width to the right
    --
    -- The line variants:
    -- nvim-various-textobjs provides line textobject
    -- "_" is a textobject for current line!
    --
    "gbprod/substitute.nvim",
    keys = {
      -- stylua: ignore start
      {"gs", function() require("substitute").operator() end, desc = "Substitute operator"},
      -- {"gss", function() require("substitute").line() end, desc = "Substitute line"},
      {"gs", function() require("substitute").visual() end, mode = {"x"}, desc = "Substitute visual"},
      -- no "S" for eol, use dollar

      {"gx", function() require("substitute.exchange").operator() end, desc = "Exchange operator"},
      -- {"gxx", function() require("substitute.exchange").line() end, desc = "Exchange line"},
      {"gx", function() require("substitute.exchange").visual() end, mode = {"x"}, desc = "Exchange visual"},

      -- Using gm instead of <leader>s.
      -- Mnemonic for now: go more, go multiply as in mini.operators
      -- also uses a register if specified, instead of the prompt
      {"gm", function() require("substitute.range").operator() end, desc = "Range operator"},
      {"gmm", function() require("substitute.range").word() end, desc = "Range word"},
      {"gm", function() require("substitute.range").visual() end, mode = {"x"}, desc = "Range visual"},
      -- stylua: ignore end
    },
    opts = { -- range: S fails to substitute using abolish
      highlight_substituted_text = { enabled = false },
    },
    -- dependencies = {
    --   { -- three superficially unrelated plugins: working with variants of a word.
    --     -- coercion (ie coerce to snake_case) crs --> Adds a cr mapping!
    --     -- abolish iabbrev, subvert substitution
    --     "tpope/vim-abolish",
    --     config = function()
    --       vim.cmd("Abolish {despa,sepe}rat{e,es,ed,ing,ely,ion,ions,or}  {despe,sepa}rat{}")
    --     end,
    --   },
    -- },
  },

  { -- better increase/decrease
    "monaqa/dial.nvim",
    -- stylua: ignore start
    keys = {
      { "<C-a>", function() return require("dial.map").inc_normal() end, expr = true, desc = "Increment" },
      { "<C-x>", function() return require("dial.map").dec_normal() end, expr = true, desc = "Decrement" },
    },
    -- stylua: ignore end
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group({
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          -- augend.date.alias["%Y/%m/%d"],
          augend.constant.alias.bool,
          -- augend.semver.alias.semver,
          -- augend.constant.new({ elements = { "let", "const" } }),
        },
      })
    end,
  },
}
