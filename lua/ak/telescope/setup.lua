--[[
-- You can override the file & generic sorter by default simply by adding
-- require("telescope").load_extension "fzy_native"

-- TODO:
-- _ = require("telescope").load_extension "git_worktree"
--]]

local ok, telescope = pcall(require, "telescope")
if not ok then
  -- print "no telescope setup"
  return
end
-- print "in telescope setup"

local has_devicons, _ = pcall(require, "nvim-web-devicons")
local actions = require "telescope.actions"
local action_layout = require "telescope.actions.layout"
local previewer = require "telescope.previewers"

local layout_config = {
  width = 0.95,
  height = 0.85,
  -- preview_cutoff = 120,
  prompt_position = "top",

  horizontal = {
    preview_width = function(_, cols, _)
      if cols > 200 then
        return math.floor(cols * 0.4)
      end
      return math.floor(cols * 0.6)
    end,
  },

  vertical = {
    width = 0.9,
    height = 0.95,
    preview_height = 0.5,
  },

  flex = {
    horizontal = {
      preview_width = 0.9,
    },
  },
}

-- KEYS: builtin telescope(mappings.lua) overrides and additions
local mappings = {
  i = {
    ["<C-x>"] = false, -- default select horizontal
    ["<C-s>"] = actions.select_horizontal,

    ["<C-e>"] = actions.results_scrolling_up,
    ["<C-y>"] = actions.results_scrolling_down,

    ["<M-p>"] = action_layout.toggle_preview,
    ["<M-m>"] = action_layout.toggle_mirror,

    -- This is nicer when used with smart-history plugin.
    ["<C-k>"] = actions.cycle_history_next,
    ["<C-j>"] = actions.cycle_history_prev,
    -- ["<c-g>s"] = actions.select_all,
    -- ["<c-g>a"] = actions.add_selection,
  },
  n = {
    ["<C-e>"] = actions.results_scrolling_up,
    ["<C-y>"] = actions.results_scrolling_down,
    ["q"] = actions.close,
  },
}

local pickers = {
  -- alias to find_files, can be configured separately
  fd = {
    hidden = true,
    mappings = {
      n = {
        ["kj"] = "close",
      },
    },
  },

  git_branches = {
    mappings = {
      i = {
        ["<C-a>"] = false,
      },
    },
  },
}

local extensions = {
  fzf = {
    fuzzy = true, -- false will only do exact matching
    override_generic_sorter = true, -- override the generic sorter
    override_file_sorter = true, -- override the file sorter
    case_mode = "smart_case", -- or "ignore_case" or "respect_case"
  },

  ["ui-select"] = {
    require("telescope.themes").get_dropdown {},
  },

  -- fzy_native = {
  --   override_generic_sorter = true,
  --   override_file_sorter = true,
  frecency = {
    -- db_root = "home/my_username/path/to/db_root",

    -- show_scores = false,
    show_scores = true,

    -- show_unindexed = true,
    -- ignore_patterns = { "*.git/*", "*/tmp/*" },
    disable_devicons = not has_devicons,
    -- workspaces = {
    --   -- ["conf"] = "/home/my_username/.config",
    --   -- ["data"] = "/home/my_username/.local/share",
    -- },
  },
}

local config = {
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    entry_prefix = "  ",
    -- multi_icon = "<>",
    winblend = 0,
    -- initial_mode = "normal", --"insert",
    layout_strategy = "horizontal",
    layout_config = layout_config,
    selection_strategy = "reset",
    -- prompt at top, ascending means better result in that area...
    -- also no more ctrl-p to cycle to best result
    sorting_strategy = "ascending",
    scroll_strategy = "cycle",
    color_devicons = has_devicons,
    mappings = mappings,
    -- file_ignore_patterns = {},
    file_previewer = previewer.vim_buffer_cat.new,
    grep_previewer = previewer.vim_buffer_vimgrep.new,
    qflist_previewer = previewer.vim_buffer_qflist.new,
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    -- fzf native overrides file_sorter and generic sorter
    --
    -- history = {
    --   path = "~/.local/share/nvim/telescope_history.sqlite3",
    --   limit = 100,
    -- },
    -- use rg, the first 7 arguments are mandatory according to tele help
    -- vimgrep_arguments = {
    --   "rg",
    --   "--color=never",
    --   "--no-heading",
    --   "--with-filename",
    --   "--line-number",
    --   "--column",
    --   "--smart-case",
    --   "--hidden",
    --   "--glob=!.git/",
    -- },
  },
  pickers = pickers,
  extensions = extensions,
}

telescope.setup(config)
_ = require("telescope").load_extension "fzf"
_ = require("telescope").load_extension "ui-select"

--[[
preloading:
You may skip explicitly loading extensions (they will then be lazy-loaded),
but tab completions will not be available right away.
--]]

-- projects supporting telescope:
-- dap: not explicitly loaded
pcall(function()
  require("telescope").load_extension "harpoon"
end)
pcall(function()
  require("telescope").load_extension "projects"
end)

-- telescope only
pcall(function()
  require("telescope").load_extension "frecency"
end)
pcall(function()
  require("telescope").load_extension "neoclip"
end)
