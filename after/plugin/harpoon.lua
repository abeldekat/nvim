-- TODO: Investigate harpoon terminal

--[[
{
    projects = {
        ["/path/to/director"] = {
            term = {
                cmds = {
                }
                ... is there anything that could be options?
            },
            mark = {
                marks = {
                }
                ... is there anything that could be options?
            }
        }
    },
    ... high level settings
}
--]]

-- local complete_config = merge_tables({
--     projects = {},
--     global_settings = {
--         ["save_on_toggle"] = false,
--         ["save_on_change"] = true,
--         ["enter_on_sendcmd"] = false,
--         ["tmux_autoclose_windows"] = false,
--         ["excluded_filetypes"] = { "harpoon" },
--         ["mark_branch"] = false,
--     },
-- }, expand_dir(c_config), expand_dir(u_config), expand_dir(config))

--[[
maybe:
lua require("harpoon.ui").nav_next()
lua require("harpoon.term").gotoTerminal(1)
lua require("harpoon.term").sendCommand(1, "ls -La")
lua require('harpoon.cmd-ui').toggle_quick_menu()
lua require("harpoon.term").sendCommand(1,1)

lua require("harpoon.tmux").gotoTerminal(1)             -- goes to the first tmux window
lua require("harpoon.tmux").sendCommand(1, "ls -la")    -- sends ls -La to tmux window 1
lua require("harpoon.tmux").sendCommand(1, 1)           -- sends command 1 to tmux window 1

lua require("harpoon.tmux").gotoTerminal("{down-of}")
lua require("harpoon.tmux").sendCommand("%1", "ls")
--]]

local ok, _ = pcall(require, "harpoon")
if not ok then
  return
end

local keymap = vim.keymap
local mark = require "harpoon.mark"
local ui = require "harpoon.ui"

-- KEY:
-- No keymap for telescope...
-- stylua: ignore start
keymap.set("n", "mn", mark.add_file, { desc = "Add file harpoon" })
keymap.set("n", "mm", ui.toggle_quick_menu, { desc = "Toggle ui harpoon" })
keymap.set("n", "ma", function() return ui.nav_file(1) end, { desc = "Nav file 1 harpoon" })
keymap.set("n", "ms", function() return ui.nav_file(2) end, { desc = "Nav file 2 harpoon" })
keymap.set("n", "md", function() return ui.nav_file(3) end, { desc = "Nav file 3 harpoon" })
keymap.set("n", "mf", function() return ui.nav_file(4) end, { desc = "Nav file 4 harpoon" })
-- stylua: ignore end
