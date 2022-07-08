local mapper = require "ak.telescope.mapper"

-- KEYS: telescope git. See also: gitsigns

local function branches()
  require("telescope.builtin").git_branches()
end
mapper.map("<leader>gB", branches, "Git checkout branch")

local function buffer_commits()
  require("telescope.builtin").git_bcommits()
end
mapper.map("<leader>gb", buffer_commits, "Git checkout commit(for current buffer)")

local function commits()
  require("telescope.builtin").git_commits {
    winblend = 5,
  }
end
mapper.map("<leader>gc", commits, "Git Checkout commit")

local function status()
  local opts = require("telescope.themes").get_ivy {
    -- previewer = true,
    -- winblend = 10,
    -- border = true,
    -- shorten_path = false,
  }
  require("telescope.builtin").git_status(opts)
end
mapper.map("<leader>gs", status, "Git Status")
mapper.map("ml", status, "Git Status")
