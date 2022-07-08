-- TODO: treesitter based folding
-- set foldmethod=expr
-- set foldexpr=nvim_treesitter#foldexpr()

local status_ok, treesitter_configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

-- parameter, function, element
-- alt space, alt pfe: next
-- alt backspace, alt pfe: previous
local swap_next, swap_prev = (function()
  local swap_objects = {
    p = "@parameter.inner",
    f = "@function.outer",
    e = "@element",
  }

  local n, p = {}, {}
  for key, obj in pairs(swap_objects) do
    n[string.format("<M-Space><M-%s>", key)] = obj
    p[string.format("<M-BS><M-%s>", key)] = obj
  end
  return n, p
end)()

-- :h nvim-treesitter-query-extensions
-- local custom_captures = {
--   ["function.call"] = "LuaFunctionCall",
--   ["function.bracket"] = "Type",
--   ["namespace.type"] = "TSNamespaceType",
-- }

-- require("nvim-treesitter.highlight").set_custom_captures(custom_captures)

local ensure_installed = {
  "bash",
  "bibtex",
  "c",
  "comment",
  "go",
  "html",
  "javascript",
  "json",
  "latex",
  "lua",
  "markdown",
  "python",
  "query",
  "ruby",
  "toml",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}

local hightlight = {
  enable = true, -- false will disable the whole extension
  -- can slow down, can be a list of languages, used for syntax indent
  -- additional_vim_regex_highlighting = false,
  -- additional_vim_regex_highlighting = "latex",
  disable = { "latex", "json" },
  use_languagetree = false,
  -- custom_captures = custom_captures,
}

local incremental_selection = {
  -- Note: gn visual mode search forward last search pattern
  -- Note: gr normal mode lsp go references
  -- normal mode:gnn, visual mode grn, grc, grm
  enable = true,
  keymaps = {
    init_selection = "gnn", --"<M-w>", -- maps in normal mode to init the node/scope selection
    node_incremental = "grn", --"<M-w>", -- increment to the upper named parent
    node_decremental = "grc", --"<M-C-w>", -- decrement to the previous node
    scope_incremental = "grm", -- "<M-e>", -- increment to the upper scope (as defined in locals.scm)
  },
}

local context_commentstring = {
  enable = true,

  -- With Comment.nvim, we don't need to run this on the autocmd.
  -- Only run it in pre-hook
  enable_autocmd = false,

  config = {
    c = "// %s",
    lua = "-- %s",
  },
}

local textobjects = {
  -- this should be possible with unimpaired...
  -- swap_next = textobj_swap_keymaps,
  move = {
    enable = true,
    set_jumps = true,

    goto_next_start = {
      ["]p"] = "@parameter.inner",
      ["]m"] = "@function.outer",
      ["]]"] = "@class.outer",
    },
    goto_next_end = {
      ["]M"] = "@function.outer",
      ["]["] = "@class.outer",
    },
    goto_previous_start = {
      ["[p"] = "@parameter.inner",
      ["[m"] = "@function.outer",
      ["[["] = "@class.outer",
    },
    goto_previous_end = {
      ["[M"] = "@function.outer",
      ["[]"] = "@class.outer",
    },
  },

  select = {
    enable = true,
    keymaps = {
      ["af"] = "@function.outer",
      ["if"] = "@function.inner",

      ["ac"] = "@conditional.outer",
      ["ic"] = "@conditional.inner",

      ["aa"] = "@parameter.outer",
      ["ia"] = "@parameter.inner",

      ["av"] = "@variable.outer",
      ["iv"] = "@variable.inner",
    },
  },

  swap = {
    enable = true,
    swap_next = swap_next,
    swap_previous = swap_prev,
  },
}

local playground = {
  enable = true,
  updatetime = 25,
  persist_queries = true,
  keybindings = {
    toggle_query_editor = "o",
    toggle_hl_groups = "i",
    toggle_injected_languages = "t",

    -- This shows stuff like literal strings, commas, etc.
    toggle_anonymous_nodes = "a",
    toggle_language_display = "I",
    focus_language = "f",
    unfocus_language = "F",
    update = "R",
    goto_node = "<cr>",
    show_help = "?",
  },
}

-- local rainbow = {
--   enable = true,
--   extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
--   max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
-- }
-- autopairs = { enable = true, },

-- autotag = {
--   enable = true,
--   -- filetypes = {
--   --   "html",
--   --   "javascript",
--   --   "javascriptreact",
--   --   "typescriptreact",
--   --   "svelte",
--   --   "vue",
--   -- },
-- },
treesitter_configs.setup {
  -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = ensure_installed,
  ignore_install = { "haskell" },
  -- indent = { enable = true, disable = { "yaml", "python" } },

  highlight = hightlight,
  incremental_selection = incremental_selection,
  context_commentstring = context_commentstring,
  textobjects = textobjects,
  playground = playground,
  -- rainbow = rainbow,
}

-- KEYS:
-- vim.cmd [[highlight IncludedC guibg=#373b41]]
vim.keymap.set("n", "<leader>Ti", "<cmd>TSConfigInfo<cr>", { desc = "Treesitter info" })
vim.keymap.set("n", "<leader>Tp", "<cmd>TSPlaygroundToggle<cr>", { desc = "Treesitter playground" })
vim.keymap.set(
  "n",
  "<leader>Th",
  "<cmd>TSHighlightCapturesUnderCursor<cr>",
  { desc = "Treesitter highlight captures under cursor" }
)
-- nvim-ts-hint-textobject
-- vim.keymap.set({ "o" }, "h", function()
--   require("tsht").nodes()
-- end, { remap = true, desc = "Treesitter hint textobject" })
-- vim.keymap.set({ "v" }, "h", function()
--   require("tsht").nodes()
-- end, { desc = "Treesitter hint textobject" })
vim.cmd [[omap     <silent> h :<C-U>lua require('tsht').nodes()<CR>]]
vim.cmd [[vnoremap <silent> h :lua require('tsht').nodes()<CR>]]
