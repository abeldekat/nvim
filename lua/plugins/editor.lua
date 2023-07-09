-- extras editor: flash, mini-files
local Util = require("lazyvim.util")

return {
  -- extras mini-files: replacement for neo-tree

  -- ---------------------------------------------
  -- disabling ....
  -- ---------------------------------------------
  -- NOTE: now using flash, faster test without flash, flit or leap:
  { "ggandor/flit.nvim", enabled = false },
  { "ggandor/leap.nvim", enabled = false },

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
      { "<leader><space>", false }, -- harpoon
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
    -- event = function()
    --   return "RemoteReply"
    -- end,
    -- keys = {
    --   {
    --     "<leader>j",
    --     function()
    --       require("which-key")
    --     end,
    --     desc = "Which-key activation",
    --   },
    -- },
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

  -- ---------------------------------------------
  -- adding ....
  -- ---------------------------------------------

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
    "ThePrimeagen/harpoon",
    -- cond = true,
    keys = {
      { -- <leader><leader> now for harpoon. Open buffers should be faster with leader o
        "<leader><space>",
        function()
          return require("harpoon.ui").toggle_quick_menu()
        end,
        desc = "Harpo[O]n Toggle UI",
      },
      {
        "<leader>fh",
        function()
          local num = tonumber(vim.fn.input("GoTo terminal window number: "))
          require("harpoon.term").gotoTerminal(num)
        end,
        desc = "[H]arpoon Terminal Window",
      },
      {
        "ma",
        function()
          return require("harpoon.mark").add_file()
        end,
        desc = "Harpoon [A]dd file",
      },
      { -- fast access: "qwerty"
        "mq",
        function()
          return require("harpoon.ui").nav_file(1)
        end,
        desc = "Harpoon [S]how File 1",
      },
      {
        "mw",
        function()
          return require("harpoon.ui").nav_file(2)
        end,
        desc = "[H]arpoon Nav File 2",
      },
      {
        "me",
        function()
          return require("harpoon.ui").nav_file(3)
        end,
        desc = "[H]arpoon Nav File 3",
      },
      {
        "mr",
        function()
          return require("harpoon.ui").nav_file(4)
        end,
        desc = "[H]arpoon Nav File 4",
      },
    },
    opts = {
      tabline = true,
    },
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
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
      vim.keymap.set("n", "mk", require("oil").open, { desc = "Oil Open Parent Directory" })
    end,
    opts = {
      -- Id is automatically added at the beginning, and name at the end
      -- See :help oil-columns
      columns = {
        "icon",
        -- "permissions",
        -- "size",
        -- "mtime",
      },
      -- Buffer-local options to use for oil buffers
      buf_options = {
        buflisted = false,
        bufhidden = "hide",
      },
      -- Window-local options to use for oil buffers
      win_options = {
        wrap = false,
        signcolumn = "no",
        cursorcolumn = false,
        foldcolumn = "0",
        spell = false,
        list = false,
        conceallevel = 3,
        concealcursor = "n",
      },
      -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`
      default_file_explorer = true,
      -- Restore window options to previous values when leaving an oil buffer
      restore_win_options = true,
      -- Skip the confirmation popup for simple operations
      skip_confirm_for_simple_edits = false,
      -- Deleted files will be removed with the trash_command (below).
      delete_to_trash = false,
      -- Change this to customize the command used when deleting to trash
      trash_command = "trash-put",
      -- Selecting a new/moved/renamed file or directory will prompt you to save changes first
      prompt_save_on_select_new_entry = true,
      -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
      -- options with a `callback` (e.g. { callback = function() ... end, desc = "", nowait = true })
      -- Additionally, if it is a string that matches "actions.<name>",
      -- it will use the mapping at require("oil.actions").<name>
      -- Set to `false` to remove a keymap
      -- See :help oil-actions for a list of all available actions
      keymaps = {
        ["g?"] = "actions.show_help",
        -- ["<CR>"] = "actions.select",
        ["l"] = "actions.select",
        ["<C-s>"] = "actions.select_vsplit",
        ["<C-h>"] = "actions.select_split",
        ["<C-t>"] = "actions.select_tab",
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["<C-l>"] = "actions.refresh",
        -- ["-"] = "actions.parent",
        ["h"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["g."] = "actions.toggle_hidden",
      },
      -- Set to false to disable all of the above keymaps
      use_default_keymaps = true,
      view_options = {
        -- Show files and directories that start with "."
        show_hidden = false,
        -- This function defines what is considered a "hidden" file
        is_hidden_file = function(name, bufnr)
          return vim.startswith(name, ".")
        end,
        -- This function defines what will never be shown, even when `show_hidden` is set
        is_always_hidden = function(name, bufnr)
          return false
        end,
      },
      -- Configuration for the floating window in oil.open_float
      float = {
        -- Padding around the floating window
        padding = 2,
        max_width = 0,
        max_height = 0,
        border = "rounded",
        win_options = {
          winblend = 10,
        },
      },
      -- Configuration for the actions floating preview window
      preview = {
        -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        -- min_width and max_width can be a single value or a list of mixed integer/float types.
        -- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
        max_width = 0.9,
        -- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
        min_width = { 40, 0.4 },
        -- optionally define an integer/float for the exact width of the preview window
        width = nil,
        -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        -- min_height and max_height can be a single value or a list of mixed integer/float types.
        -- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
        max_height = 0.9,
        -- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
        min_height = { 5, 0.1 },
        -- optionally define an integer/float for the exact height of the preview window
        height = nil,
        border = "rounded",
        win_options = {
          winblend = 0,
        },
      },
      -- Configuration for the floating progress window
      progress = {
        max_width = 0.9,
        min_width = { 40, 0.4 },
        width = nil,
        max_height = { 10, 0.9 },
        min_height = { 5, 0.1 },
        height = nil,
        border = "rounded",
        minimized_border = "none",
        win_options = {
          winblend = 0,
        },
      },
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
