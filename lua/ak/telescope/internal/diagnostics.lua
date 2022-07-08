local mapper = require "ak.telescope.mapper"

--KEY: Telescope Diagnostics

local function buffer_diagnostics()
  local opts = require("telescope.themes").get_ivy {
    bufnr = 0,
  }
  require("telescope.builtin").diagnostics(opts)
end
mapper.map("<leader>db", buffer_diagnostics, "Telescope Buffer Diagnostics")

local function workspace_diagnostics()
  local opts = require("telescope.themes").get_ivy {}
  require("telescope.builtin").diagnostics(opts)
end
mapper.map("<leader>dw", workspace_diagnostics, "Telescope Workspace Diagnostics")

local function quickfix_diagnostics()
  local opts = require("telescope.themes").get_ivy {}
  require("telescope.builtin").diagnostics(opts)
end
mapper.map("<leader>dq", quickfix_diagnostics, "Telescope Quickfix Diagnostics")
