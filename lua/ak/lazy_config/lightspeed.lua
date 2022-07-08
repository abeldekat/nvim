--[[
flawless dot-repeat support for operators (with repeat.vim installed)
skips repeated (3+) sequences of the same character, for preserving labels (opt-out)
greys out the search area, like EasyMotion does (opt-out)
  ...
  in Operator-pending mode the search is invoked with z/Z, acknowledging that "surround" plugins may benefit even more from being able to use s/S then.
  ...
  --> TODO no luck with for example ds or dz
  --> TODO lightspeed_x not mapped?

  ...
  The mnemonic for X-mode could be extend/exclude (corresponding to x/X). It provides missing variants for the two directions:
  ...

  ...
  Lightspeed also overrides the native f/F/t/T motions with enhanced versions that work over multiple lines.
  In all other respects they behave the same way as the native ones.
  ...
  The newline character is represented by <enter> in search patterns. For example, f<enter> is equivalent to $,

  ...
  Instant" repeat (after jumping)

    In Normal and Visual mode, the motions can be repeated by pressing the corresponding trigger key - s, f, t
  ...

  ...

  ...
  Lightspeed aims to be part of an "extended native" layer, similar to such canonized Vim plugins like surround.vim or targets.vim.
  Therefore it provides carefully thought-out defaults, mapping to the following keys: s, S (Normal and Visual mode), z, Z, x, X (Operator-pending mode),
  and - obviously, enhancing the built-in motions - f, F, t, T, ;, , (all modes).

That said, Lightspeed will check for conflicts with any custom mappings created by you or other plugins, and will not overwite them, unless explicitly told so.
To set alternative keymaps, you can use the below listed <Plug> keys, available in all modes.
  ...
]]

--[[
-- Note: This is just illustration - there is no need to copy/paste the
-- defaults, or call `setup` at all, if you do not want to change anything.
require'lightspeed'.setup {
  ignore_case = false,
  exit_after_idle_msecs = { unlabeled = 1000, labeled = nil },

  -- s/x
  grey_out_search_area = true,
  highlight_unique_chars = true,
  jump_on_partial_input_safety_timeout = 400,
  match_only_the_start_of_same_char_seqs = true,
  substitute_chars = { ['\r'] = '¬' },
  -- Leaving the appropriate list empty effectively disables
  -- "smart" mode, and forces auto-jump to be on or off.
  safe_labels = { . . . },
  labels = { . . . },
  cycle_group_fwd_key = '<space>',
  cycle_group_bwd_key = '<tab>',

  -- f/t
  limit_ft_matches = 4,
  repeat_ft_with_target_char = false,
}
]]
