-- { -- testing lazy loading vim functions call floaterm#new(v:true, 'fzf', {}, {})
--   "voldikss/vim-floaterm",
--   lazy = true, -- as expected, cannot call the function when lazy
-- },

local Util = require("lazyvim.util")
local which_key_autoload = false

return {
  -- ---------------------------------------------
  -- disabling ....
  -- ---------------------------------------------
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },

  -- NOTE: vim-illuminate:
  -- <a-n>, <a-p> as keymaps, <a-i> as textobject, without the i and a verbs
  -- lazyvim also provides reference movements:[[,]], Not overridden: [], ][
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
      -- change top-level keys:
      -- ---------------------------------------------

      -- "leader ,", switch buffer:
      { "<leader>o", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "[O]ther buffers" },
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
        "<leader>fp",
        function()
          require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
        end,
        desc = "[P]lugin Files",
      },
      { "<leader>gb", "<cmd>Telescope git_bcommits<cr>", desc = "Buffer [b]lame Commits" },
      { "<leader>si", "<cmd>Telescope<cr>", desc = "Telescope built[i]n" },
    },
  },

  {
    "folke/which-key.nvim",
    event = function()
      return which_key_autoload and { "VeryLazy" } or {}
    end,
    keys = function() -- no keys defined in LazyVim
      -- stylua: ignore start
      return which_key_autoload and {}
        or {{ "<leader>mw", function() require("which-key") end, desc = "[W]hich-key" }}
      -- stylua: ignore end
    end,
    opts = function(_, opts)
      opts.defaults["<leader>q"] = nil -- no submenu, immediate quit
      opts.defaults["<leader>w"] = nil -- no submenu, immediate write

      -- delete buffer, session commands and lazy
      opts.defaults["<leader>m"] = { name = "+[m]isc" }
      opts.defaults["gz"] = nil
      opts.defaults["<leader>z"] = { name = "+[z]urround" }
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

  -- {
  --   "echasnovski/mini.comment",
  --   event = function()
  --     return { "BufReadPost", "BufNewFile", "BufWritePost" } -- VeryLazy
  --   end,
  -- },
  --
  -- {
  --   "echasnovski/mini.pairs",
  --   event = function()
  --     return { "BufReadPost", "BufNewFile", "BufWritePost" } -- VeryLazy
  --   end,
  -- },
  --
  -- {
  --   "echasnovski/mini.ai",
  --   event = function()
  --     return { "BufReadPost", "BufNewFile", "BufWritePost" } -- VeryLazy
  --   end,
  -- },
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

  -- replaces vim-illuminate
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
    -- keys seen in other configs: <leader> ha hn hp ht, ctrln ctrlp for prev and next
    "ThePrimeagen/harpoon",
    keys = function()
      local function nav(a_number)
        require("harpoon.ui").nav_file(a_number)
      end

      return {
        -- stylua: ignore start
        { "<leader>,",
          function()
            require("harpoon.ui").toggle_quick_menu()
          end, desc = "[H]arpoon", },
        { "ma",
          function()
            require("harpoon.mark").add_file()
          end, desc = "Harpoon [A]dd", },
        { "<leader>h", function() nav(1) end, desc = "Harpoon 1", },
        { "<leader>j", function() nav(2) end, desc = "Harpoon 2", },
        { "<leader>k", function() nav(3) end, desc = "Harpoon 3", },
        { "<leader>l", function() nav(4) end, desc = "Harpoon 4", },

        { "<leader>fh",
          function()
            local num = tonumber(vim.fn.input("GoTo terminal window number: "))
            require("harpoon.term").gotoTerminal(num)
          end, desc = "[H]arpoon Terminal Window" },
        -- stylua: ignore end
      }
    end,
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
