--[[
Leap has the concept of reusing safe labels in a separate group("blue lables in example")
Press space to switch to the separate group
Smart autojump
Operator-pending mode, z/Z, x/X (extend/exclude)
Jumping to the last character on a line, press enter after it
Cross-window motions: gs searches in all the other windows on the tab page.
Bidirectional search: omni. Cross window behaves this way by default
Traversal mode, s<char>enter, like f over multiple lines
Repeating motions
]]
--           [[:n "s"  "<Plug>(leap-forward)"]
--            [:n "S"  "<Plug>(leap-backward)"]
--            [:x "s"  "<Plug>(leap-forward)"]
--            [:x "S"  "<Plug>(leap-backward)"]
--            [:o "z"  "<Plug>(leap-forward)"]
--            [:o "Z"  "<Plug>(leap-backward)"]
--            [:o "x"  "<Plug>(leap-forward-x)"]
--            [:o "X"  "<Plug>(leap-backward-x)"]
--            [:n "gs" "<Plug>(leap-cross-window)"]
--            [:x "gs" "<Plug>(leap-cross-window)"]
--            [:o "gs" "<Plug>(leap-cross-window)"]])]

-- local config = {
--   case_insensitive = true,
--   -- Leaving the appropriate list empty effectively disables "smart" mode,
--   -- and forces auto-jump to be on or off.
--   -- safe_labels = { . . . },
--   -- labels = { . . . },
--   -- These keys are captured directly by the plugin at runtime.
--   special_keys = {
--     repeat_search = "<enter>",
--     next_match = "<enter>",
--     prev_match = "<tab>",
--     next_group = "<space>",
--     prev_group = "<tab>",
--     eol = "<space>",
--   },
-- }

local ok, leap = pcall(require, "leap")
if not ok then
  return
end

local use_default = false
local use_omni = false

-- -- KEY: Leap navigation
local function set_keymaps()
  local set = vim.keymap.set

  if use_default then
    leap.set_default_keymaps()
  else
    -- Using omni, map s to omni and do not map S
    if use_omni then
      set({ "n", "x" }, "s", "<Plug>(leap-omni)", { desc = "Leap omni n and v mode" })
    else
      set({ "n", "x" }, "s", "<Plug>(leap-forward)", { desc = "Leap forward n and v mode" })
      -- Note vim surround forces S in visual mode
      set({ "n", "x" }, "S", "<Plug>(leap-backward)", { desc = "Leap backward n and v mode" })
    end

    set({ "o" }, "z", "<Plug>(leap-forward)", { desc = "Leap forward operator mode" })
    set({ "o" }, "Z", "<Plug>(leap-backward)", { desc = "Leap backward operator mode" })
    set({ "o" }, "x", "<Plug>(leap-forward-x)", { desc = "Leap forward operator extended mode" })
    set({ "o" }, "X", "<Plug>(leap-backward-x)", { desc = "Leap backward operator excluded mode" })

    -- -- Note: Conflict with buffer mapping lsp: gs, show signature
    set(
      { "n", "x", "o" },
      "gS",
      "<Plug>(leap-cross-window)",
      { desc = "Leap cross window normal,visual and operator mode" }
    )
  end
end

-- :h leap-config
set_keymaps()
