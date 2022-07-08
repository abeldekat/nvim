The trigger for rethinking:
1 The config of tjdevries(why are these configs in after/plugin?)
2 The problems with lualine overriding showtabline to 2 on setup and on colorscheme event
About lualine: It used to be on bufwinenter, thus, after the colorscheme event
Given that lazy loading makes no sense and offers no benefits,as lualine is always immediately used, bufwinenter was removed.
Now, lualine's setup executed before the colorscheme event and a setup was triggered twice...
A correction of the showtabline(always set to true by lualine) was needed

Packer: 
1 manage plugins in site/pack
2 load the plugins if configured to do so:
2a: with a config, a setup attribute
2b: lazy markers: module, keys, commands, events
2c: conditionals, etc

Regarding 2a, the majority of plugins are not lazyloaded and do have a config for setup
It is not necessary for packer to also be responsible for this basic use case.
Those configs can be placed in after/plugin, for neovim to load them automatically in alphabatic order
All those configs are safe to load already, having a require guard at the top of the file
Advantages:
1: This makes the configs that do benefit from being loaded by packer standout... A clear special case, apparently offering benefits.
2: packer_compiled is much clearer, as all of the following lines disappear:
-- Config for: LuaSnip
time([[Config for LuaSnip]], true)
try_loadstring("\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22ak.config.luasnip\frequire\0", "config", "LuaSnip")
time([[Config for LuaSnip]], false)
3. packer compiled will only be for lazy loading. The order will be init.lua, plugin/packer_compiled for setting up lazy loading, after/plugin for direct loading 
4. A cleaner separation. Packer becomes less prominant and important. This config already took steps into that direction by completely 
refactoring packer out of the main ak package, into its own pa
5. Whenever lazy loading needs to be disabled, the steps to do so are clearer.

Disadvantages:
Speed, very, very little. Think 54ms instead of 53ms, or 135ms instead of 133ms
Configs doing setup are not all in one place
