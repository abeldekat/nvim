return {
  -- ---------------------------------------------
  -- disabling ....
  -- ---------------------------------------------
  { "echasnovski/mini.comment", enabled = false },
  { "echasnovski/mini.pairs", enabled = false },
  { "echasnovski/mini.ai", enabled = false },
  { "echasnovski/mini.surround", enabled = false },

  -- ---------------------------------------------
  -- adding ....
  -- ---------------------------------------------

  { -- mini.comment.
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

  { -- mini.pairs. See NOTES.md
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

  { -- mini.ai. See NOTES.md
    "chrisgrieser/nvim-various-textobjs",
    event = { "LazyFile" },
    opts = function(_, _)
      vim.keymap.set("o", "gc", '<cmd>lua require("various-textobjs").multiCommentedLines()<CR>')
      return {
        useDefaultKeymaps = true,
        -- stylua: ignore
        disabledKeymaps = {
          "R", "r", -- restOfIndentation, restOfParagraph: flash...
          "ig", "ag", -- greedyOuterIndentation: not used
          "gc", -- multiCommentedLines: comment.nvim... Only use operator pending
          "n", -- nearEol: minus one char: overrides next search result
          "ik", "ak", -- key: treesitter block...
          "!", -- diagnostic: not used
          "iz", "az", -- closed fold: not used
          "im", "am", -- chainMember: not used
          -- filetype specific: not used
          "iC", "aC", "ic", "ac", "ix", "ax", "iD", "aD", "iP", "aP",
        },
      }
    end,
  },

  { -- mini.surround. See NOTES.md
    "kylechui/nvim-surround",
    version = "*",
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

  { -- mini.operators
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

  -- { -- split/join using treesitter. See discussion 19. No markdown support.
  --   "Wansmer/treesj",
  --   keys = { { "gJ", "<cmd>TSJToggle<cr>", desc = "Join Toggle" } },
  --   opts = { use_default_keymaps = false, max_join_length = 150 },
  -- },
}
