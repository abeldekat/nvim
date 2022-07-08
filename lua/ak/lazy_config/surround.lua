--[[
  Note: currently using tpope/surround, no config

  Note: setting to S works perfectly, s is for peak

  This plugin is very powerful for HTML and XML editing, a niche which currently seems underfilled in Vim land
  Not so much for this lua version... See tpope surround

  https://github.com/machakann/vim-sandwich
  https://github.com/Mephistophiles/surround.nvim
  using Mephistophiles/surround.nvim

The s mapping:
n  stB           <Plug>SurroundToggleBrackets -- only in sandwich
n  stb           <Plug>SurroundToggleBrackets -- only in sandwich, cycle?
n  stq           <Plug>SurroundToggleQuotes --cq, tpopse cs"'
n  sr            <Plug>SurroundReplace --cs
n  sd            <Plug>SurroundDelete --ds
n  sa            <Plug>SurroundAddNormal -- ys
x  s             <Plug>SurroundAddVisual -- tpope same
n  ss            <Plug>SurroundRepeat --only in sandwich

a menu could be:
  s = {
    name = "Surround",
    ["."] = { "<cmd>lua require('surround').repeat_last()<cr>", "Repeat" },
    a = { "<cmd>lua require('surround').surround_add(true)<cr>", "Add" },
    d = { "<cmd>lua require('surround').surround_delete()<cr>", "Delete" },
    r = { "<cmd>lua require('surround').surround_replace()<cr>", "Replace" },
    q = { "<cmd>lua require('surround').toggle_quotes()<cr>", "Quotes" },
    b = { "<cmd>lua require('surround').toggle_brackets()<cr>", "Brackets" },
  },

Lots of mappings in insert mode <C-S>: !surround1, to 6
    <c-s><char> will insert both pairs in insert mode.
    <c-s><char><space> will insert both pairs in insert mode with surrounding whitespace.
    <c-s><char><c-s> will insert both pairs on newlines insert mode.

Doesn't support python docstrings and html tags yet. Either can be added to the pairs table with an alias as shortcut.
(No dynamic tags yet, though. You need to add the tags you want beforehand.)

]]

local status_ok, surround = pcall(require, "surround")
if not status_ok then
  return
end

surround.setup {
  -- number of lines to look for above and below the current line while searching for nestable pairs
  context_offset = 100,
  -- filetype javascript,typescript:
  load_autogroups = false,
  -- 		-- Insert Mode Ctrl-S mappings. <C-S> is not mapped by default
  map_insert_mode = false,
  quotes = { "'", '"' },
  brackets = { "(", "{", "[" },
  pairs = {
    nestable = { b = { "(", ")" }, s = { "[", "]" }, B = { "{", "}" }, a = { "<", ">" } },
    linear = { q = { "'", "'" }, t = { "`", "`" }, d = { '"', '"' } },
  },
  -- if the closing char should add surround space rather than the opening char.
  space_on_closing_char = false,
  prompt = true,
  mappings_style = "sandwich",
  prefix = "S",
}
