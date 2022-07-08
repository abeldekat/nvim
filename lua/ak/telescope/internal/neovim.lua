local mapper = require "ak.telescope.mapper"

-- KEYS: telescope neovim related
-- fp is for projects extension:
-- also interesting:
-- telescope.builtin.reloader
-- telescope.builtin.command_history

local function find_buffers()
  local opts = require("telescope.themes").get_dropdown {
    previewer = false,
  }
  require("telescope.builtin").buffers(opts)
end
-- handy, next to e for find files
mapper.map("<leader>r", find_buffers, "Find buffers")

local function oldfiles()
  -- local opts = require("telescope.themes").get_dropdown {
  --   previewer = false,
  --   path_display = { "truncate" },
  -- }
  -- require("telescope.builtin").oldfiles(opts)

  local opts = require("telescope.themes").get_ivy {}
  require("telescope").extensions.frecency.frecency(opts)
end
mapper.map("<leader>o", oldfiles, "Find recent files")

local function neoclip()
  local n = require("telescope").extensions.neoclip
  local opts = {}
  n.default(opts)
end
mapper.map("<leader>fy", neoclip, "Find yanks with neoclip")

local function builtin()
  local opts = {
    scroll_strategy = "limit",
  }
  require("telescope.builtin").builtin(opts)
end
mapper.map("<leader>t", builtin, "Builtin")

local function commands()
  require("telescope.builtin").commands()
end
mapper.map("<leader>fc", commands, "Commands")

-- Overriden by files custom colors
--
-- local function colorscheme()
--   require("telescope.builtin").colorscheme()
-- end
-- mapper.map("<leader>fC", colorscheme, "Colorscheme")

-- Not in use, the fp is projects fP is packages
--
-- local function colorscheme_with_preview()
--   local opts = {
--     enable_preview = true,
--   }
--   require("telescope.builtin").colorscheme(opts)
-- end
-- mapper.map("<leader>fP", colorscheme_with_preview, "Colorscheme with Preview")

mapper.map("<leader>fh", function()
  local opts = require("telescope.themes").get_dropdown {
    previewer = false,
  }
  require("telescope.builtin").help_tags(opts)
end, "Help")

local function highlights()
  require("telescope.builtin").highlights()
end
mapper.map("<leader>fH", highlights, "Highlights")

local function keymaps()
  require("telescope.builtin").keymaps()
end
mapper.map("<leader>fk", keymaps, "Keymaps")

local function man_pages()
  require("telescope.builtin").man_pages()
end
mapper.map("<leader>fm", man_pages, "Man pages")

local function registers()
  require("telescope.builtin").registers()
end
mapper.map("<leader>fr", registers, "Registers")

local function vim_options()
  require("telescope.builtin").vim_options {
    layout_config = {
      width = 0.5,
    },
  }
end
mapper.map("<leader>fo", vim_options, "Vim options")

local function treesitter()
  require("telescope.builtin").treesitter()
end
mapper.map("<leader>ft", treesitter, "Treesitter")
