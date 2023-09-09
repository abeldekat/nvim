-- maybe: windwp/nvim-ts-autotag
-- maybe: nvim-various-textobjs

return {

  -- Note: Mini does not override capital B
  --
  -- incremental, g[: never used...
  -- ia b: alias for [({, use vim's b and B
  -- ia q: alias for `"', specify the quotes...
  -- ia ?, user prompt: use flash s...
  --
  -- Rarely used:
  -- Default textobject is activated for identifiers
  -- from digits (0, ..., 9),
  -- punctuation (like `_`, `*`, `,`, etc.),
  -- whitespace (space, tab, etc.)
  -- --> Without mini.ai, first navigate to identifier
  --
  -- dot repeat: missing with treesitter textobject?
  --
  -- Is it possible to use mini.ai and textobjects together?
  -- Removing the overlap, without mini.ai's gen_spec.treesitter?
  {
    "echasnovski/mini.ai",
    enabled = false,
    -- opts = function(_, opts)
    --   opts.custom_textobjects = {
    --     t = false, -- fallback to neovim for tags
    --   }
    -- end,
  },

  -- treesitter textobjects: b is stock neovim, uses k for block
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      -- mini.ai disabled: override lazyvim's dependencies. No need for load_textobjects.
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        init = function() end, -- override
      },
    },
    opts = function(_, opts)
      -- mini.ai disabled: textobjects taken from AstroNvim:
      opts.textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["ak"] = { query = "@block.outer", desc = "around block" },
            ["ik"] = { query = "@block.inner", desc = "inside block" },
            ["ac"] = { query = "@class.outer", desc = "around class" },
            ["ic"] = { query = "@class.inner", desc = "inside class" },
            ["a?"] = { query = "@conditional.outer", desc = "around conditional" },
            ["i?"] = { query = "@conditional.inner", desc = "inside conditional" },
            ["af"] = { query = "@function.outer", desc = "around function " },
            ["if"] = { query = "@function.inner", desc = "inside function " },
            ["al"] = { query = "@loop.outer", desc = "around loop" },
            ["il"] = { query = "@loop.inner", desc = "inside loop" },
            ["aa"] = { query = "@parameter.outer", desc = "around argument" },
            ["ia"] = { query = "@parameter.inner", desc = "inside argument" },
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]k"] = { query = "@block.outer", desc = "Next block start" },
            ["]f"] = { query = "@function.outer", desc = "Next function start" },
            ["]a"] = { query = "@parameter.inner", desc = "Next argument start" },
          },
          goto_next_end = {
            ["]K"] = { query = "@block.outer", desc = "Next block end" },
            ["]F"] = { query = "@function.outer", desc = "Next function end" },
            ["]A"] = { query = "@parameter.inner", desc = "Next argument end" },
          },
          goto_previous_start = {
            ["[k"] = { query = "@block.outer", desc = "Previous block start" },
            ["[f"] = { query = "@function.outer", desc = "Previous function start" },
            ["[a"] = { query = "@parameter.inner", desc = "Previous argument start" },
          },
          goto_previous_end = {
            ["[K"] = { query = "@block.outer", desc = "Previous block end" },
            ["[F"] = { query = "@function.outer", desc = "Previous function end" },
            ["[A"] = { query = "@parameter.inner", desc = "Previous argument end" },
          },
        },
        swap = {
          enable = true,
          swap_next = {
            [">K"] = { query = "@block.outer", desc = "Swap next block" },
            [">F"] = { query = "@function.outer", desc = "Swap next function" },
            [">A"] = { query = "@parameter.inner", desc = "Swap next argument" },
          },
          swap_previous = {
            ["<K"] = { query = "@block.outer", desc = "Swap previous block" },
            ["<F"] = { query = "@function.outer", desc = "Swap previous function" },
            ["<A"] = { query = "@parameter.inner", desc = "Swap previous argument" },
          },
        },
      }

      vim.list_extend(opts.ensure_installed, {
        "awk",
        "rust",
      })
    end,
    config = function(_, opts) -- override
      -- mini.ai disabled: No need for load_textobjects.

      if type(opts.ensure_installed) == "table" then
        ---@type table<string, boolean>
        local added = {}
        opts.ensure_installed = vim.tbl_filter(function(lang)
          if added[lang] then
            return false
          end
          added[lang] = true
          return true
        end, opts.ensure_installed)
      end
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
