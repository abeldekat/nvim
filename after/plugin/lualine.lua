local ok, lualine = pcall(require, "lualine")
if not ok then
  return
end

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local titleCase = function(first, rest)
  return first:upper() .. rest:lower()
end

local mode = {
  "mode",
  -- fmt = function(str) return "-" .. str .. "-" end,
  fmt = function(str)
    return string.gsub(str, "(%a)([%w_']*)", titleCase)
  end,
}

local branch = {
  "branch",
  icons_enabled = true,
  icon = "",
}

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = { error = " ", warn = " " },
  colored = false,
  update_in_insert = false,
  always_visible = false,
}

-- vim status line items as a lua component...
local centered = "%="

local icon = {
  "filetype",
  icon_only = true,
  colored = false,
}

local filename = {
  "filename",
  file_status = true,
  path = 1,
}

local diff = {
  "diff",
  colored = false,
  -- symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
  cond = hide_in_width,
  padding = 0,
}

local encoding = {
  "encoding",
  fmt = function(str)
    if str == "utf-8" then
      return "utf"
    else
      return "OTH"
    end
  end,
  padding = { right = 1 },
  cond = hide_in_width,
}

local filetype = {
  "filetype",
  icons_enabled = false,
  cond = hide_in_width,
  padding = { right = 1 },
}

local location = {
  "location",
  -- padding = 0,
}

local spaces = {
  function()
    return " [" .. vim.api.nvim_buf_get_option(0, "shiftwidth") .. "]"
  end,
  cond = hide_in_width,
  padding = { right = 1 },
}

-- cool function for progress
local progress = {
  function()
    local current_line = vim.fn.line "."
    local total_lines = vim.fn.line "$"
    local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
    local line_ratio = current_line / total_lines
    local index = math.ceil(line_ratio * #chars)
    return chars[index]
  end,
  cond = hide_in_width,
}

local tabs = {
  "tabs",
  max_length = vim.o.columns, -- / 3, -- Maximum width of tabs component.
  -- Note:
  -- It can also be a function that returns
  -- the value of `max_length` dynamically.
  mode = 2, -- 0: Shows tab_nr
  -- 1: Shows tab_name
  -- 2: Shows tab_nr + tab_name

  tabs_color = {
    -- Same values as the general color option can be used here.
    -- active = "lualine_{section}_normal", -- Color for active tab.
    -- inactive = "lualine_{section}_inactive", -- Color for inactive tab.
    active = "lualine_a_normal", -- Color for active tab.
    inactive = "lualine_a_inactive", -- Color for inactive tab.
  },
}

-- after the setup, lualine registers an autocommand on colorscheme
-- If lualine is loaded before the colorscheme event:
-- This triggers setup() once more overwriting showtabline into 2
local function repair_showtabline()
  -- vim.cmd([[autocmd lualine ColorScheme * lua require'lualine'.setup()

  local function after_lualine_setup()
    vim.opt.showtabline = 1
    vim.cmd [[autocmd! lualine Colorscheme *]]
  end

  after_lualine_setup()
  local lualine_repair = vim.api.nvim_create_augroup("ak_lualine_repair", {})
  vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
      require("lualine").setup()
      after_lualine_setup()
    end,
    group = lualine_repair,
    desc = "Overwrite showtabline change caused by lualine setup on colorscheme event",
  })
end

lualine.setup {
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = true,
  },
  sections = {
    lualine_a = { mode },
    lualine_b = { branch, diagnostics },
    lualine_c = { centered, icon, filename },
    -- lualine_x = { diff, spaces, "encoding", filetype },
    lualine_x = { diff, spaces, encoding, filetype },
    -- lualine_y = { location,tabs },
    lualine_y = { location },
    lualine_z = { progress },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {
    lualine_a = { tabs },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  extensions = {},
}
repair_showtabline()

-- KEY: Lualine tabrename, misc
vim.keymap.set("n", "<leader>mr", ":LualineRenameTab ", { desc = "Lualine Tab Rename" })
