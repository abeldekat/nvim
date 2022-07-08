--[[
--
--LUA SNIPPETS LOADER
Instead of adding all snippets via add_snippets, it's possible to store them in separate files (each for one filetype) and load all of those.
For this, the files need to be
    in a single directory. The directory may be passed directly to load(), or it can be named luasnippets and in the runtimepath, in which case it will be automatically detected.
    named <filetype>.lua or in a subdirectory <filetype>/somename.lua (Snipmate-structure).
    return two lists of snippets (either may be nil). The snippets in the first are regular snippets for <filetype>, the ones in the second are autosnippets (make sure they are enabled if this table is used).
As defining all of the snippet-constructors (s, c, t, ...) in every file is rather cumbersome, luasnip will bring some globals into scope for executing these files.
By default the names from Examples/snippets.lua will be used, but it's possible to customize them by setting snip_env in setup.
These collections can be loaded directly (require("luasnip.loaders.from_lua").load(opts)) or lazily (require("luasnip.loaders.from_lua").lazy_load(opts)).
lua-opts may contain the same keys as vscode-opts, but here include and exclude can be used in lazy_load.
Apart from loading, from_lua also exposes functions to edit files associated with the currently active filetypes, which could be called via an command, for example:

command! LuaSnipEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files()

Once loaded, files will be reloaded on save (BufWritePost).
Example:

~/snippets/all.lua:
return {
	ls.parser.parse_snippet("trig", "loaded!!")
}

~/snippets/c.lua:
return {
	ls.parser.parse_snippet("ctrig", "also loaded!!")
}, {
	ls.parser.parse_snippet("autotrig", "autotriggered, if enabled")
}

Load via
require("luasnip.loaders.from_lua").load({paths = "~/snippets"})
--]]

---@diagnostic disable: undefined-global
return {
  -- Note: ls is not defined in snip_env
  -- ls.parser.parse_snippet("trig", "loaded!!"),
  parse("trig", "loaded!!"),
}
