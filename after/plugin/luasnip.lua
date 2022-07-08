local ok, ls = pcall(require, "luasnip")
if not ok then
  return
end

local types = require "luasnip.util.types"

local config = {
  -- This tells LuaSnip to remember to keep around the last snippet.
  -- You can jump back into it even if you move outside of the selection
  history = true,

  -- This one is cool cause if you have dynamic snippets, it updates as you type!
  updateevents = "TextChanged,TextChangedI",

  -- Autosnippets:
  enable_autosnippets = true,

  -- Crazy highlights!!
  -- ext_opts = nil,
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { " <- Current Choice", "NonTest" } },
      },
    },
  },

  -- see source code, lua/luasnip/config.lua
  -- globals injected into luasnippet-files.
  snip_env = {
    s = require("luasnip.nodes.snippet").S,
    sn = require("luasnip.nodes.snippet").SN,
    t = require("luasnip.nodes.textNode").T,
    f = require("luasnip.nodes.functionNode").F,
    i = require("luasnip.nodes.insertNode").I,
    c = require("luasnip.nodes.choiceNode").C,
    d = require("luasnip.nodes.dynamicNode").D,
    r = require("luasnip.nodes.restoreNode").R,
    l = require("luasnip.extras").lambda,
    rep = require("luasnip.extras").rep,
    p = require("luasnip.extras").partial,
    m = require("luasnip.extras").match,
    n = require("luasnip.extras").nonempty,
    dl = require("luasnip.extras").dynamic_lambda,
    fmt = require("luasnip.extras.fmt").fmt,
    fmta = require("luasnip.extras.fmt").fmta,
    conds = require "luasnip.extras.expand_conditions",
    types = require "luasnip.util.types",
    events = require "luasnip.util.events",
    parse = require("luasnip.util.parser").parse_snippet,
    ai = require "luasnip.nodes.absolute_indexer",
  },
}

-- KEY: Luasnip
local set_keys = function()
  -- <c-k> is my expansion key
  -- this will expand the current item or jump to the next item within the snippet.
  vim.keymap.set({ "i", "s" }, "<c-k>", function()
    if ls.expand_or_jumpable() then
      ls.expand_or_jump()
    end
  end, { desc = "Luasnip expand current or jump. Overrides digraph key", silent = true })

  -- <c-j> is my jump backwards key.
  -- this always moves to the previous item within the snippet
  vim.keymap.set({ "i", "s" }, "<c-j>", function()
    if ls.jumpable(-1) then
      ls.jump(-1)
    end
  end, { desc = "Luasnip jump back, overrides newline in insert mode", silent = true })

  -- <c-l> is selecting within a list of options. Choice nodes
  vim.keymap.set("i", "<c-l>", function()
    if ls.choice_active() then
      ls.change_choice(1)
    end
  end, { desc = "Luasnip change choice" })

  -- vim.keymap.set("i", "<c-u>", require "luasnip.extras.select_choice")

  -- TODO: Activate?
  -- vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/lua/ak.config/luasnip.lua<CR>")
end

--[[
-- -- vscode style snippets, a lot of people have already written...
-- -- lsp with snippet cap. also supplies vscode style snippets... 
--       ls.parser.parse_snippet("expand", "-- this is what was expanded!"),
lua:
  Add the snippets by calling require("luasnip").add_snippets(filetype, snippets)
This can also be done much better (one snippet-file per filetype+command for editing the current filetype+reload on edit)
than in the example by using the loader for lua
There's also a repository collecting snippets for various languages, molleweide/LuaSnip-snippets.nvim
--]]
ls.config.set_config(config)
set_keys()

-- require("luasnip.loaders.from_lua").load()
require("luasnip.loaders.from_lua").lazy_load()

-- -- load snippets from path/of/your/nvim/config/my-cool-snippets
-- require("luasnip.loaders.from_vscode").lazy_load { paths = { "./my-cool-snippets" } }
-- load vscode style snippets, completion via cmp-luasnip
require("luasnip/loaders/from_vscode").lazy_load()
