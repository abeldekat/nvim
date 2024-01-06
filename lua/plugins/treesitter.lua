return {

  { -- treesitter textobjects: uses k for block, b is preserved
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            -- TODO: test treesitter assignment
            --
            ["a="] = { query = "@assignment.outer", desc = "outer part of assignment" },
            ["i="] = { query = "@assignment.inner", desc = "inner part of assignment" },
            -- ["l="] = { query = "@assignment.lhs", desc = "left hand side of assignment" },
            ["k="] = { query = "@assignment.lhs", desc = "left hand side of assignment" },
            -- ["r="] = { query = "@assignment.rhs", desc = "right hand side of assignment" },
            ["v="] = { query = "@assignment.rhs", desc = "right hand side of assignment" },
            -- block
            ["ak"] = { query = "@block.outer", desc = "around block" },
            ["ik"] = { query = "@block.inner", desc = "inside block" },
            -- class
            ["ac"] = { query = "@class.outer", desc = "around class" },
            ["ic"] = { query = "@class.inner", desc = "inside class" },
            -- conditional: also possible: ii ai
            ["a?"] = { query = "@conditional.outer", desc = "around conditional" },
            ["i?"] = { query = "@conditional.inner", desc = "inside conditional" },
            -- function: -- also consider @call for function only
            ["af"] = { query = "@function.outer", desc = "around function" },
            ["if"] = { query = "@function.inner", desc = "inside function" },
            -- loop
            ["al"] = { query = "@loop.outer", desc = "around loop" },
            ["il"] = { query = "@loop.inner", desc = "inside loop" },
            -- parameter
            ["aa"] = { query = "@parameter.outer", desc = "around argument" },
            ["ia"] = { query = "@parameter.inner", desc = "inside argument" },
          },
        },
        move = { -- now supported by LazyVim --> copied the c, already have the f
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]c"] = { query = "@class.outer", desc = "Next class start" },
            ["]k"] = { query = "@block.outer", desc = "Next block start" },
            ["]f"] = { query = "@function.outer", desc = "Next function start" },
            ["]a"] = { query = "@parameter.inner", desc = "Next argument start" },
          },
          goto_next_end = {
            ["]C"] = { query = "@class.outer", desc = "Next class end" },
            ["]K"] = { query = "@block.outer", desc = "Next block end" },
            ["]F"] = { query = "@function.outer", desc = "Next function end" },
            ["]A"] = { query = "@parameter.inner", desc = "Next argument end" },
          },
          goto_previous_start = {
            ["[c"] = { query = "@class.outer", desc = "Previous class start" },
            ["[k"] = { query = "@block.outer", desc = "Previous block start" },
            ["[f"] = { query = "@function.outer", desc = "Previous function start" },
            ["[a"] = { query = "@parameter.inner", desc = "Previous argument start" },
          },
          goto_previous_end = {
            ["[C"] = { query = "@class.outer", desc = "Previous class end" },
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

      local function activate_repeatable_move()
        local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
        local modes = { "n", "x", "o" }
        vim.keymap.set(modes, ";", ts_repeat_move.repeat_last_move)
        vim.keymap.set(modes, ",", ts_repeat_move.repeat_last_move_opposite)
        vim.keymap.set(modes, "f", ts_repeat_move.builtin_f)
        vim.keymap.set(modes, "F", ts_repeat_move.builtin_F)
        vim.keymap.set(modes, "t", ts_repeat_move.builtin_t)
        vim.keymap.set(modes, "T", ts_repeat_move.builtin_T)
      end

      if require("lazyvim.util").has("eyeliner.nvim") then
        local use_eyeliner = true -- default, eyeliner is parsed before treesitter
        vim.keymap.set("n", "<leader>um", function()
          use_eyeliner = not use_eyeliner
          if use_eyeliner then
            pcall(vim.keymap.del, { "n", "x", "o" }, ";")
            pcall(vim.keymap.del, { "n", "x", "o" }, ",")
            vim.cmd("EyelinerEnable")
          else
            vim.cmd("EyelinerDisable")
            activate_repeatable_move()
          end
        end, { desc = "Toggle Treesitter Repeatable Move" })
      else
        activate_repeatable_move()
      end

      vim.list_extend(opts.ensure_installed, {
        "awk",
        "rust",
        "xml",
      })
    end,
  },
}
