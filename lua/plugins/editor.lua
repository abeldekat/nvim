local Util = require("lazyvim.util")
local which_key_autoload = false

return {

  -- ---------------------------------------------
  -- disabling ....
  -- ---------------------------------------------
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  { "nvim-pack/nvim-spectre", enabled = false },
  -- use bdelete[!], or bwipeout:
  { "echasnovski/mini.bufremove", enabled = false },

  -- ---------------------------------------------
  -- overriding ....
  -- ---------------------------------------------
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-project.nvim",
        dependencies = "telescope-file-browser.nvim",
        keys = {
          {
            "<leader>fp",
            function()
              require("telescope").extensions.project.project()
            end,
            desc = "Telescope Project",
          },
        },
        config = function()
          require("telescope").load_extension("project")
        end,
      },

      {
        "nvim-telescope/telescope-file-browser.nvim",
        keys = {
          {
            "<space>fB",
            function()
              require("telescope").extensions.file_browser.file_browser()
            end,
            desc = "Telescope file_browser",
          },
        },
        config = function()
          require("telescope").load_extension("file_browser")
        end,
      },

      {
        "jvgrootveld/telescope-zoxide", -- <c-b> does not work
        keys = {
          {
            "<space>fz",
            function()
              require("telescope").extensions.zoxide.list()
            end,
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
      -- change top-level keys:
      -- ---------------------------------------------

      -- "leader ,", switch buffer:

      { "<leader>o", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "[O]ther buffers" },
      { "<leader>,", false }, -- disable to use harpoon

      -- "leader /", live grep:
      {
        "<leader>e",
        function()
          Util.telescope("live_grep", require("telescope.themes").get_ivy({}))()
        end,
        desc = "Gr[e]p (root)",
      },
      {
        "<leader>/", -- buffer fuzzy find, from "leader sb"
        function()
          require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
            winblend = 10,
            previewer = false,
          }))
        end,
        desc = "Search in buffer",
      },

      -- ---------------------------------------------
      -- add new bindings:
      -- ---------------------------------------------
      -- oldfiles, from "leader fR":
      {
        "<leader>r",
        function()
          Util.telescope("oldfiles", { cwd = vim.loop.cwd() })()
        end,
        desc = "[R]ecent (cwd)",
      },
      -- plugins, from the example:
      {
        "<leader>fP", -- fp is for telescope project
        function()
          require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
        end,
        desc = "[P]lugin Files",
      },
      { "<leader>gb", "<cmd>Telescope git_bcommits<cr>", desc = "Buffer [b]lame Commits" },
      { "<leader>si", "<cmd>Telescope<cr>", desc = "Telescope built[i]n" },
    },
    opts = function(_, opts) -- PR #1459 -- also see lua/telescope/mappings.lua
      local layout_actions = require("telescope.actions.layout")
      opts.defaults = vim.tbl_deep_extend("force", opts.defaults, {
        mappings = {
          i = {
            ["<a-p>"] = layout_actions.toggle_preview,
            ["<a-m>"] = layout_actions.toggle_mirror,
            ["<a-o>"] = layout_actions.toggle_prompt_position,
            ["<Down>"] = layout_actions.cycle_layout_prev, -- duplicate move_selection_previous
            ["<Up>"] = layout_actions.cycle_layout_next, -- duplicate move_selection_end
            ["<C-c>"] = false, -- double escape actions.close,
            -- LazyVim:
            ["<C-f>"] = false, -- duplicate actions.preview_scrolling_down,
            ["<C-b>"] = false, -- duplicate actions.preview_scrolling_up,
          },
          n = { -- No LazyVim mappings, use the defaults like select tab in normal mode...
            ["<Down>"] = false,
            ["<Up>"] = false,
          },
        },
        layout_strategy = "flex",
        layout_config = {
          horizontal = {
            preview_width = 0.55,
          },
          vertical = {
            width = 0.9,
            height = 0.95,
            preview_height = 0.5,
            preview_cutoff = 0,
          },
          flex = {
            flip_columns = 140,
          },
        },
      })
    end,
  },

  {
    "folke/which-key.nvim",
    event = function()
      return which_key_autoload and { "VeryLazy" } or {}
    end,
    keys = function() -- LazyVim does not define keys for which-key
      return which_key_autoload and {}
        or {
          {
            "<leader>uk",
            function()
              require("which-key")
            end,
            desc = "Activate Which-[k]ey",
          },
        }
    end,
    opts = function(_, opts)
      opts.defaults["<leader>b"] = nil
      opts.defaults["<leader>q"] = nil -- no submenu
      opts.defaults["<leader>w"] = nil -- no submenu

      -- session commands and lazy
      opts.defaults["<leader>m"] = { name = "+[m]isc" }
      opts.defaults["gs"] = nil
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
    lazy = true,
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
    keys = function()
      local function add()
        require("harpoon.mark").add_file()
      end
      local function ui()
        require("harpoon.ui").toggle_quick_menu()
      end
      local function nav(a_number)
        require("harpoon.ui").nav_file(a_number)
      end
      local function prev()
        require("harpoon.ui").nav_prev()
      end
      local function next()
        require("harpoon.ui").nav_next()
      end
      local function to_terminal()
        local num = tonumber(vim.fn.input("Terminal window number: "))
        require("harpoon.term").gotoTerminal(num)
      end

      -- stylua: ignore
      return {
        { "<leader>j", ui, desc = "Harpoon ui" },
        { "<leader>k", add, desc = "Harpoon add" },
        { "<leader>n", next, desc = "Harpoon [n]ext" },
        { "<leader>p", prev, desc = "Harpoon [p]rev" },
        { "<leader>fh", to_terminal, desc = "[H]arpoon terminal" },
        -- test changing from <leader>{hjkl}:
        { "<c-j>", function() nav(1) end, desc = "Harpoon 1" },
        { "<c-k>", function() nav(2) end, desc = "Harpoon 2" },
        { "<c-h>", function() nav(3) end, desc = "Harpoon 3" },
        { "<c-l>", function() nav(4) end, desc = "Harpoon 4" },
      }
    end,
    opts = { tabline = false },
  },

  {
    "stevearc/oil.nvim",
    keys = { { "mk", "<cmd>Oil<cr>", desc = "Oil Open Directory" } },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function() -- see LazyVim, neotree
      if vim.fn.argc() == 1 then
        ---@diagnostic disable-next-line: param-type-mismatch
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then
          require("oil")
        end
      end
    end,
    opts = {
      keymaps = { -- ["g?"] = "actions.show_help",
        ["<CR>"] = false,
        ["l"] = "actions.select", --  "CR"
        ["<C-h>"] = false,
        ["<C-s>"] = "actions.select_split", --  "C-h" window navigation
        ["<C-v>"] = "actions.select_vsplit", -- "C-s"
        ["<C-c>"] = false,
        ["q"] = "actions.close", --  "<C-c>"
        ["<C-l>"] = false,
        ["<C-r>"] = "actions.refresh", --  "C-l" window navigation
        ["-"] = false,
        ["h"] = "actions.parent", --  "-"
        ["_"] = false, -- "actions.open_cwd"
      },
      use_default_keymaps = true, -- false
    },
  },

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
