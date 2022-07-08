local mapper = require "ak.telescope.mapper"

-- KEY: Telescope search(grep)
-- <leader>fg , reasonable for grep, is reserved for git_files

local function current_buffer_fuzzy_find()
  local opts = require("telescope.themes").get_dropdown {
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
  }
  require("telescope.builtin").current_buffer_fuzzy_find(opts)
end
-- map_tele("<space>ff", "curbuf")
mapper.map("<leader>b", current_buffer_fuzzy_find, "Search current buffer fuzzy find")

local function grep_for_word_under_cursor()
  require("telescope.builtin").grep_string()
end
mapper.map("<leader>fw", grep_for_word_under_cursor, "Search workspace for word under cursor")

local function grep_for_exact_word_under_cursor()
  local opts = {
    short_path = true,
    word_match = "-w",
    only_sort_text = true,
    layout_strategy = "vertical",
    sorter = require("telescope.sorters").get_fzy_sorter(),
  }
  require("telescope.builtin").grep_string(opts)
end
mapper.map("<leader>fe", grep_for_exact_word_under_cursor, "Search workspace for --exact-- word under cursor")

local function grep_live_text()
  local opts = require("telescope.themes").get_ivy {
    -- previewer = false,
    fzf_separator = "|>",
  }
  require("telescope.builtin").live_grep(opts)
end
-- tjdevries: map_tele("<space>fg", "multi_rg")
mapper.map("<leader>fl", grep_live_text, "Search workspace, live text ")

local function grep_last_searched()
  local register = vim.fn.getreg("/"):gsub("\\<", ""):gsub("\\>", ""):gsub("\\C", "")

  local opts = {
    layout_strategy = "vertical",
    path_display = { "shorten" },
    word_match = "-w",
    search = register,
  }
  require("telescope.builtin").grep_string(opts)
end
mapper.map("<leader>f/", grep_last_searched, "Search workspace for last searched word")

-- same as live_grep, but prompted for additional input before showing picker:
-- local function grep_prompt()
--   require("telescope.builtin").grep_string {
--     path_display = { "shorten" },
--     search = vim.fn.input "Grep String > ",
--   }
-- end
-- mapper.map("<leader>fq", grep_prompt, "Search workspace for last searched word")
