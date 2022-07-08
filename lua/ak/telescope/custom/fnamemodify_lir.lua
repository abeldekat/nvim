--[[
  Put a filename in several formats into the + register
]]
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local lir = require "lir"

local find_git_ancestor = require("lspconfig.util").find_git_ancestor

local fnamemodify = function(mods)
  return function(path)
    return vim.fn.fnamemodify(path, mods)
  end
end

local git_fnamemodify = function(mods)
  mods = vim.F.if_nil(mods, ":p")
  return function(path)
    local root = find_git_ancestor(path)
    if root == nil then
      return nil
    end

    path = vim.fn.fnamemodify(path, mods)
    return path:sub(#root + 2)
  end
end

local fnamemods = {
  fnamemodify ":p:t",
  git_fnamemodify(),
  git_fnamemodify ":p:h",
  git_fnamemodify ":p:h:h",
  fnamemodify ":p",
  fnamemodify ":p:h",
  fnamemodify ":p:h:h",
}

return function()
  local ctx = lir.get_context()
  local cur_path = ctx:current().fullpath
  local results = {}
  for _, mod in ipairs(fnamemods) do
    local res = mod(cur_path)
    if res and res ~= "" then
      table.insert(results, res)
    end
  end

  pickers.new({}, {
    prompt_title = "Paths",
    finder = finders.new_table {
      results = results,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry,
          ordinal = entry,
        }
      end,
    },
    sorter = conf.generic_sorter {},
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        local entry = action_state.get_selected_entry()
        actions.close(prompt_bufnr)

        vim.fn.setreg(vim.v.register, entry.value)
      end)

      return true
    end,
  }):find()
end
