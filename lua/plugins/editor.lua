-- extras editor: mini-files
local Util = require("lazyvim.util")

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
    -- add fzf native
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
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
    event = function()
      return {} -- removes verylazy event
    end,
    keys = {
      {
        "<leader>mw",
        function()
          require("which-key")
        end,
        desc = "Which-key activation",
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
    lazy = false,
    init = function()
      vim.g.hardtime_default_on = 1
    end,
    keys = {
      { "<leader>mh", "<cmd>HardTimeToggle<cr>", desc = "Toggle HardTime" },
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
    -- also seen <leader> ha hn hp ht
    -- ctrln ctrpp for prev and next
    "ThePrimeagen/harpoon",

    -- stylua: ignore start
    keys = {
      { "<leader>h",
        function()
          return require("harpoon.ui").toggle_quick_menu()
        end, desc = "Harpoon UI",},
      { "<leader>fh",
        function()
          local num = tonumber(vim.fn.input("GoTo terminal window number: "))
          require("harpoon.term").gotoTerminal(num)
        end, desc = "[H]arpoon Terminal Window", },
      { "ma",
        function()
          return require("harpoon.mark").add_file()
        end, desc = "Harpoon [A]dd file", },

      -- fast access: "qwer"
      { "mq",
        function()
          return require("harpoon.ui").nav_file(1)
        end, desc = "Harpoon [S]how File 1", },
      { "mw",
        function()
          return require("harpoon.ui").nav_file(2)
        end, desc = "[H]arpoon Nav File 2", },
      { "me",
        function()
          return require("harpoon.ui").nav_file(3)
        end, desc = "[H]arpoon Nav File 3", },
      { "mr",
        function()
          return require("harpoon.ui").nav_file(4)
        end, desc = "[H]arpoon Nav File 4", },
    },
    -- stylua: ignore end

    opts = { tabline = false },
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

  {
    "stevearc/oil.nvim",
    -- stylua: ignore
    keys = {{ "mk", function() require("oil").open() end, desc = "Oil Open Directory" }},
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

  -- { -- copied partially from astronvim, using <leader><leader>
  --   "cbochs/grapple.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim" },
  --   cmd = { "Grapple" },
  --   -- cond = false,
  --   keys = {
  --     {
  --       "<leader>j",
  --       function()
  --         require("grapple").select({ key = "placeholder" })
  --       end,
  --       desc = "Select name",
  --     },
  --     {
  --       "<leader>J",
  --       function()
  --         require("grapple").toggle({ key = "placeholder" })
  --       end,
  --       desc = "Toggle name",
  --     },
  --     { "m" .. "a", "<cmd>GrappleTag<CR>", desc = "Add file" },
  --     { "m" .. "d", "<cmd>GrappleUntag<CR>", desc = "Remove file" },
  --     { "m" .. "t", "<cmd>GrappleToggle<CR>", desc = "Toggle a file" },
  --     { "m" .. "e", "<cmd>GrapplePopup tags<CR>", desc = "Select from tags" },
  --     { "m" .. "s", "<cmd>GrapplePopup scopes<CR>", desc = "Select a project scope" },
  --     { "m" .. "x", "<cmd>GrappleReset<CR>", desc = "Clear tags from current project" },
  --     { "<C-n>", "<cmd>GrappleCycle forward<CR>", desc = "Select next tag" },
  --     { "<C-p>", "<cmd>GrappleCycle backward<CR>", desc = "Select previous tag" },
  --   },
  -- },
}
