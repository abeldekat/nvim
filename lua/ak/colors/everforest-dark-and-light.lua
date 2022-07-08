--[[
    "sainnhe/everforest",

  Everforest is a green based color scheme, it's designed to be warm and soft in order to protect developers' eyes.
]]

local toggler_factory = require "ak.core.keytoggler"
toggler_factory.reset_keys()
local bg = toggler_factory.background_toggler_adapter()

local contrast_toggler = toggler_factory.new_contrast_toggler({
  "soft",
  "medium",
  "hard",
}, "soft")

local function activate()
  bg.apply_background()
  vim.g.everforest_background = contrast_toggler.value
  vim.cmd [[colorscheme everforest]]
end
bg.on_toggle_background(activate)
contrast_toggler:on_toggle(activate)

vim.cmd [[packadd color_everforest]]
activate()

--[[
function! everforest#get_configuration() "{{{
  return {
        \ 'background': get(g:, 'everforest_background', 'medium'),
        \ 'transparent_background': get(g:, 'everforest_transparent_background', 0),
        \ 'disable_italic_comment': get(g:, 'everforest_disable_italic_comment', 0),
        \ 'enable_italic': get(g:, 'everforest_enable_italic', 0),
        \ 'cursor': get(g:, 'everforest_cursor', 'auto'),
        \ 'menu_selection_background': get(g:, 'everforest_menu_selection_background', 'white'),
        \ 'sign_column_background': get(g:, 'everforest_sign_column_background', 'default'),
        \ 'ui_contrast': get(g:, 'everforest_ui_contrast', 'low'),
        \ 'show_eob': get(g:, 'everforest_show_eob', 1),
        \ 'current_word': get(g:, 'everforest_current_word', get(g:, 'everforest_transparent_background', 0) == 0 ? 'grey background' : 'bold'),
        \ 'lightline_disable_bold': get(g:, 'everforest_lightline_disable_bold', 0),
        \ 'diagnostic_text_highlight': get(g:, 'everforest_diagnostic_text_highlight', 0),
        \ 'diagnostic_line_highlight': get(g:, 'everforest_diagnostic_line_highlight', 0),
        \ 'diagnostic_virtual_text': get(g:, 'everforest_diagnostic_virtual_text', 'grey'),
        \ 'better_performance': get(g:, 'everforest_better_performance', 0),
        \ }
endfunction "}}}
]]
