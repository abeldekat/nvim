--[[
A very useful lir action copied from their github wiki
Search all inner directories of the current cwd
Refactored a bit to be indepent of lir( not using float )

Modified to always work from cwd.
--> Consequence: Outside of the project, type @ in lir to change directory

This has much similarities to file_browser in folder_browser mode.
That file browser starts up in file_browser mode, showing the files in the cwd,
which is the same as lir's starting position
]]

local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
-- local utils = require "telescope.utils"

local function result()
  local cwd
  -- local is_lir = vim.bo.filetype == "lir"

  -- if is_lir then
  --   ak: no preview in this branch of the code
  --   cwd = vim.fn.expand "%:p"
  -- else
  --   -- もし、git のディレクトリだったら、 root を使う
  --   cwd = vim.fn.getcwd()
  --   local output = utils.get_os_command_output({ "git", "rev-parse", "--show-toplevel" }, cwd)
  --   if output[1] and not vim.tbl_isempty(output) then
  --     cwd = output[1]
  --   end
  -- end
  cwd = vim.fn.getcwd()

  local opts = require("telescope.themes").get_ivy {}
  pickers.new(opts, {
    prompt_title = "lir fd directory",
    finder = finders.new_oneshot_job({ "fd", "--color=never", "--type", "directory" }, {
      cwd = cwd,
    }),
    sorter = conf.generic_sorter {},
    previewer = conf.file_previewer {
      -- depth = 1
    },
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        local entry = action_state.get_selected_entry()
        actions.close(prompt_bufnr)

        -- if is_lir then
        --   vim.cmd("e " .. cwd .. "/" .. entry.value)
        -- else
        --   require("lir.float").init(cwd .. "/" .. entry.value)
        -- end
        vim.cmd("e " .. cwd .. "/" .. entry.value)
      end)

      return true
    end,
  }):find()
end

return result
