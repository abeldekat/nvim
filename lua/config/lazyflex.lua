local M = {}

local presets = { -- added
  coding = {
    "comment.nvim",
    "nvim-autopairs",
    "nvim-various-textobjs",
    "nvim-surround",
    "substitute.nvim",
    "dial.nvim",
  },
  editor = {
    "telescope-zoxide",
    "eyeliner.nvim",
    "vim-hardtime",
    "toggleterm.nvim",
    "harpoon",
    "oil.nvim",
    "git-blame.nvim",
  },
  lsp = {
    "symbols-outline.nvim",
  },
  treesitter = {
    "nvim-treesitter-context",
  },
  util = {
    "vim-slime",
    "markdown-preview.nvim",
    "glow.nvim",
  },
}

-- only act on plenary when enabling plugins
-- other plugins might crash with plenary disabled
local when_enabling = {
  editor = { "plenary" }, -- TODO: Test and expand!
}

M.get_preset_keywords = function(name, enable_on_match)
  local result = presets[name]

  if result and enable_on_match then
    local extra = when_enabling[name]
    if extra then
      result = vim.list_extend(vim.list_extend({}, result), extra)
    end
  end
  return result or {}
end

M.return_spec = function(config) -- config
  -- TODO:
  if config.autocmds == false then
    -- package.loaded["config.autocmds"] = true
  end
  if config.keymaps == false then
    -- package.loaded["config.keymaps"] = true
  end

  return {}
end

return M
