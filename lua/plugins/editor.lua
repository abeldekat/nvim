-- extras editor: mini-files
local Util = require("lazyvim.util")
local clues_enabled = true
local clues_event = true
local which_key_enabled = true
local which_key_event = false

return {
  -- extras mini-files: replacement for neo-tree

  -- ---------------------------------------------
  -- disabling ....
  -- ---------------------------------------------

  -- always disabled:
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },

  -- NOTE: vim-illuminate:
  -- <a-n>, <a-p> as keymaps, <a-i> as textobject, without the i and a verbs
  -- lazyvim also provides reference movements:[[,]], Untouched: [], ][
  -- --> replace with mini.cursorword:
  -- disadvantage: no prev and next with treesitter/lsp/regexp
  { "RRethy/vim-illuminate", enabled = false },

  -- ---------------------------------------------
  -- overriding ....
  -- ---------------------------------------------
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      -- add fzf native
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
      -- Zoxide file integration, c-b integration to file browser fails...
      {
        "jvgrootveld/telescope-zoxide",
        keys = {
          {
            "<space>fz",
            ":Telescope zoxide list<cr>",
            desc = "Zoxide file navigation",
          },
        },
        config = function()
          require("telescope").load_extension("zoxide")
        end,
      },
    },
    keys = {
      -- ---------------------------------------------
      -- disabling ....
      -- ---------------------------------------------
      { "<leader>,", false }, -- not in use
      { "<leader><space>", false }, -- not in use
      -- ---------------------------------------------
      -- overriding ....
      -- ---------------------------------------------
      -- "<leader>," into:
      { "<leader>o", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "[O]pen Buffers" },
      -- "<leader>sb" copied to:
      {
        "<leader>/",
        function()
          require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
            winblend = 10,
            previewer = false,
          }))
        end,
        desc = "S[/]earch Current Buffer",
      },
      -- ---------------------------------------------
      -- adding ....
      -- ---------------------------------------------
      -- "<leader><space>", same as "<leader>ff":
      { "<leader>e", Util.telescope("files"), desc = "[E]xplore Files (root)" },
      -- "<leader>/":
      { "<leader>r", Util.telescope("live_grep"), desc = "G[R]ep (root)" },
      -- "<leader>fR":
      { "<leader>?", Util.telescope("oldfiles", { cwd = vim.loop.cwd() }), desc = "[O]ld files (cwd)" },
      { -- From Example: Add a keymap to browse plugin files
        "<leader>fp",
        function()
          require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
        end,
        desc = "[P]lugin Files",
      },
      -- git blame commits
      { "<leader>gb", "<cmd>Telescope git_bcommits<cr>", desc = "Buffer [B]lame Commits" },
      -- Add telescope builtIn:
      { "<leader>si", "<cmd>Telescope<cr>", desc = "Telescope Built[I]n" },
    },
  },

  {
    "folke/which-key.nvim",
    cond = which_key_enabled,
    event = function()
      return which_key_event and { "VeryLazy" } or {}
    end,
    keys = {
      {
        "<leader>mw",
        function()
          require("which-key")
        end,
        desc = "[W]hich-key",
      },
    },
    opts = function(_, opts)
      opts.defaults["<leader>q"] = nil -- no submenu, immediate quit
      opts.defaults["<leader>w"] = nil -- no submenu, immediate write

      -- delete buffer, session commands and lazy
      opts.defaults["<leader>m"] = { name = "+[M]isc" }
      opts.defaults["gz"] = nil
      opts.defaults["<leader>z"] = { name = "+[Z]urround" }
      return opts
    end,
  },

  {
    "folke/flash.nvim",
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
          -- multi_line = false,
          -- hide after jump when not using jump labels
          autohide = false, -- default
          -- show jump labels
          jump_labels = true, -- default
        },
      },
    },
  },

  -- ---------------------------------------------
  -- adding ....
  -- ---------------------------------------------

  { -- disabled flash for fFtT
    "jinh0/eyeliner.nvim",
    event = "VeryLazy",
    config = function()
      require("eyeliner").setup({
        highlight_on_key = true, -- show highlights only after keypress
        dim = true, -- dim all other characters if set to true (recommended!)
      })
    end,
  },

  {
    "takac/vim-hardtime",
    -- lazy = false,
    init = function()
      vim.g.hardtime_default_on = 1
    end,
    keys = {
      { "<leader>mh", "<cmd>HardTimeToggle<cr>", desc = "[H]ardTime" },
    },
    config = function()
      vim.g.hardtime_ignore_buffer_patterns = { "oil.*" }
      vim.g.hardtime_showmsg = 1
      vim.g.hardtime_motion_with_count_resets = 1

      --vim.g.list_of_disabled_keys = []
      --vim.g.hardtime_timeout = 2000
      --vim.g.hardtime_ignore_quickfix = 1
      --vim.g.hardtime_allow_different_key = 1
      --vim.g.hardtime_maxcount = 2
    end,
  },

  { "echasnovski/mini.cursorword", event = { "BufReadPost", "BufNewFile" }, config = true },

  -- { -- testing lazy loading vim functions call floaterm#new(v:true, 'fzf', {}, {})
  --   "voldikss/vim-floaterm",
  --   lazy = true, -- as expected, cannot call the function when lazy
  -- },

  { --To map /: use <C-_> instead of <C-/>.
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = { { [[<c-_>]], "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" } },
    cmd = {
      "TermExec",
      "ToggleTerm",
      "ToggleTermToggleAll",
      "ToggleTermSendCurrentLine",
      "ToggleTermSendVisualLines",
      "ToggleTermSendVisualSelection",
    },
    opts = {
      size = 15,
      open_mapping = [[<c-_>]],
      insert_mappings = false,
      terminal_mappings = false,
      shading_factor = 2,
      direction = "horizontal",
    },
  },

  {
    -- keys seen in other configs:
    -- <leader> ha hn hp ht
    -- ctrln ctrpp for prev and next
    "ThePrimeagen/harpoon",
    -- stylua: ignore start
    keys = {
      { "<leader>h",
        function()
          return require("harpoon.ui").toggle_quick_menu()
        end, desc = "[H]arpoon",},
      { "<leader>fh",
        function()
          local num = tonumber(vim.fn.input("GoTo terminal window number: "))
          require("harpoon.term").gotoTerminal(num)
        end, desc = "[H]arpoon Terminal Window", },
      { "mm",
        function()
          return require("harpoon.mark").add_file()
        end, desc = "Harpoon [M]ark", },

      -- fast access: "as"
      -- fast access: "zx"
      { "ma", function() return require("harpoon.ui").nav_file(1) end, desc = "Harpoon File 1", },
      { "ms", function() return require("harpoon.ui").nav_file(2) end, desc = "Harpoon File 2", },
      { "mz", function() return require("harpoon.ui").nav_file(3) end, desc = "Harpoon File 3", },
      { "mx", function() return require("harpoon.ui").nav_file(4) end, desc = "Harpoon File 4", },
    },
    -- stylua: ignore end
    opts = { tabline = false },
  },

  {
    "stevearc/oil.nvim",
    -- stylua: ignore
    keys = {{ "mk", "<cmd>Oil<cr>", desc = "Oil Open Directory" }},
    -- stylua: ignore
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function() -- see LazyVim, neotree
      if vim.fn.argc() == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then
          require("oil")
        end
      end
    end,
    opts = {
      keymaps = {
        ["g?"] = "actions.show_help",
        -- ["<CR>"] = "actions.select",
        ["l"] = "actions.select", -- changed
        ["<C-s>"] = "actions.select_vsplit",
        ["<C-h>"] = "actions.select_split",
        ["<C-t>"] = "actions.select_tab",
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["<C-l>"] = "actions.refresh",
        -- ["-"] = "actions.parent", -- changed
        ["h"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["g."] = "actions.toggle_hidden",
      },
      use_default_keymaps = false, -- changed
    },
  },

  {
    "echasnovski/mini.clue",
    event = function()
      return clues_event and { "VeryLazy" } or {}
    end,
    cond = clues_enabled,
    keys = {
      {
        "<leader>mc",
        function()
          require("mini.clue")
        end,
        desc = "[C]lue",
      },
    },
    opts = function(_, _)
      local miniclue = require("mini.clue")
      return {
        window = {
          -- config = { anchor = "SE", row = "auto", col = "auto" },
          config = { width = "auto" },
        },

        triggers = {
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

        clues = {
          -- Enhance this by adding descriptions for <Leader> mapping groups
          miniclue.gen_clues.builtin_completion(),
          miniclue.gen_clues.g(),
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers(),
          miniclue.gen_clues.windows(),
          miniclue.gen_clues.z(),

          { mode = "n", keys = "<leader><tab>", desc = "+tabs" },
          { mode = "n", keys = "<leader>b", desc = "+buffer" },
          { mode = "n", keys = "<leader>c", desc = "+code" },
          { mode = "n", keys = "<leader>d", desc = "+debug" },
          { mode = "n", keys = "<leader>f", desc = "+file/find" },
          { mode = "n", keys = "<leader>g", desc = "+git" },
          { mode = "n", keys = "<leader>gh", desc = "+hunks" },
          { mode = "n", keys = "<leader>m", desc = "+misc" },
          { mode = "n", keys = "<leader>s", desc = "+search" },
          { mode = "n", keys = "<leader>t", desc = "+test" },
          { mode = "n", keys = "<leader>u", desc = "+ui" },
          { mode = "n", keys = "<leader>x", desc = "+diagnostics/quickfix" },
        },
      }
    end,
  },

  -- git blame
  {
    "f-person/git-blame.nvim",
    cmd = "GitBlameToggle",
    keys = {
      {
        "<leader>gt",
        function()
          vim.cmd("GitBlameToggle")
        end,
        desc = "[T]oggle gitblame",
      },
    },
    opts = {
      date_format = "%x",
    },
  },
}
