local mapper = require "ak.telescope.mapper"

-- KEY: Project

pcall(function()
  -- only add the mapping if project is present
  require "project_nvim"
  local function projects()
    local p = require("telescope").extensions.projects
    local opts = {}
    p.projects(opts)
  end
  mapper.map("<leader>fp", projects, "Find Projects")
end)
