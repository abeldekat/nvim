local M = {}

local presets = {
  coding = {
    "comment.nvim",
    "nvim-autopairs",
    "nvim-various-textobjs",
    "nvim-surround",
    "substitute.nvim",
    "dial.nvim",
    -- "treesj",
  },
  editor = {
    "telescope-zoxide",
    "telescope-file-browser.nvim",
    "telescope-project.nvim",
    "eyeliner.nvim",
    "vim-hardtime",
    "toggleterm.nvim",
    "harpoon",
    "oil.nvim",
    "git-blame.nvim",
  },
  ui = {
    "fidget.nvim",
  },
  util = {
    "vim-slime",
  },
}

local when_enabling = {
  editor = { "plenary" },
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

M.change_settings = function(settings)
  if settings.options == false then
    package.loaded["config.options"] = true
    vim.g.mapleader = " "
    vim.g.maplocalleader = "\\"
  end
  if settings.autocmds == false then
    package.loaded["config.autocmds"] = true
  end
  if settings.keymaps == false then
    package.loaded["config.keymaps"] = true
  end

  return {}
end

return M
