local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end
-- icons: find more here: https://www.nerdfonts.com/cheat-sheet
local ok, lspkind = pcall(require, "lspkind")
if not ok then
  return
end
lspkind.init()

-- local todo = {
-- activate completion:
-- TODO: This does not work. TMUX? See breaking changes....
-- ["<c-space>"] = cmp.mapping {
--   i = cmp.mapping.complete(),
--   c = function(
--     _ --[[fallback]]
--   )
--     if cmp.visible() then
--       if not cmp.confirm { select = true } then
--         return
--       end
--     else
--       cmp.complete()
--     end
--   end,
-- },
-- }
local mapping = {

  ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
  ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
  ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),

  ["<CR>"] = cmp.mapping.confirm { select = false },
  ["<c-y>"] = cmp.mapping(
    cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },
    { "i", "c" }
  ),
  ["<C-e>"] = cmp.mapping {
    i = cmp.mapping.abort(),
    c = cmp.mapping.close(),
  },

  ["<Tab>"] = cmp.config.disable,
  ["<S-Tab>"] = cmp.config.disable,
}

local formatting = {
  format = lspkind.cmp_format {
    with_text = true,
    menu = {
      buffer = "[buf]",
      nvim_lsp = "[LSP]",
      nvim_lua = "[api]",
      luasnip = "[snip]",
      path = "[path]",
      tmux = "[tmux]",
    },
  },
}

local sources = {
  { name = "luasnip" },
  { name = "nvim_lsp" },
  { name = "nvim_lua" },
  { name = "buffer", keyword_length = 2 },
  { name = "tmux" },
  { name = "path", keyword_length = 3 },
}

local config = {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  window = {},
  mapping = cmp.mapping.preset.insert(mapping),
  formatting = formatting,
  sources = cmp.config.sources(sources),
  experimental = {
    ghost_text = false,
  },
  -- view = { entries = 'native' }
  completion = {
    keyword_length = 1,
  },
}

cmp.setup(config)

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})
