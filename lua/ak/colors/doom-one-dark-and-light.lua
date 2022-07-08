--[[
https://github.com/NTBBloodbath/doom-one.nvim

-- TODO: On save and exec:
E5113: Error while calling lua chunk: Vim:E121: Undefined variable: amount
stack traceback:
        [C]: in function 'map'
        ...ck/packer/opt/color_doom-one/lua/doom-one/utils/init.lua:77: in function 'Darken'
        ...ite/pack/packer/opt/color_doom-one/lua/doom-one/init.lua:230: in function 'load_colorscheme'
        ...ite/pack/packer/opt/color_doom-one/lua/doom-one/init.lua:24: in function 'setup'
        ...s/.config/nvim/lua/ak/colors/doom-one-dark-and-light.lua:54: in function 'activa
Note: It does load when the theme is set in colorscheme.lua

 This colorscheme is ported from doom-emacs' doom-one. 

    Optional terminal colors
    Optional italic comments
    Optional TreeSitter support
    Optional transparent background
    Optional support for numerous plugins (nvim-tree, barbar, lspsaga, etc)

  Contribute
    Fork it (https://github.com/NTBBloodbath/doom-one.nvim/fork)
    Create your feature branch (git checkout -b my-new-feature)
    Commit your changes (git commit -am 'Add some feature')
    Push to the branch (git push origin my-new-feature)
    Create a new Pull Request

]]

local toggler_factory = require "ak.core.keytoggler"
toggler_factory.reset_keys()
local bg = toggler_factory.background_toggler_adapter()

local config = {
  cursor_coloring = false,
  terminal_colors = false,
  italic_comments = false,
  enable_treesitter = true,
  transparent_background = false,
  pumblend = {
    enable = true,
    transparency_amount = 20,
  },
  plugins_integrations = {
    neorg = false,
    barbar = false,
    bufferline = false,
    gitgutter = false,
    gitsigns = true,
    telescope = true,
    neogit = false,
    nvim_tree = true,
    dashboard = false,
    startify = false,
    whichkey = false,
    indent_blankline = true,
    vim_illuminate = false,
    lspsaga = false,
  },
}

local function activate()
  require("doom-one").setup(config)
  bg.apply_background()
  vim.cmd [[colorscheme doom-one]]
end
bg.on_toggle_background(activate)

vim.cmd [[packadd color_doom-one]]
activate()
