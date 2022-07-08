-- " Available Debug Adapters:
-- "   https://microsoft.github.io/debug-adapter-protocol/implementors/adapters/
-- " Adapter configuration and installation instructions:
-- "   https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
-- " Debug Adapter protocol:
-- "   https://microsoft.github.io/debug-adapter-protocol/
-- " Debugging

local status_ok, _ = pcall(require, "dap")
if not status_ok then
  return
end

-- KEY: DAP
-- see also: Telescpe
local related_keyprefix = "<leader>R"

local set = vim.keymap.set
local add = function(lhs, rhs, desc)
  set("n", lhs, rhs, { desc = "DAP " .. desc })
end
local rel_add = function(lhs, rhs, desc)
  add(related_keyprefix .. lhs, rhs, desc)
end

local ui_config = {
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r", --The REPL provided by nvim-dap.
    toggle = "t",
  },
  sidebar = {
    -- You can change the order of elements in the sidebar
    elements = {
      -- Provide as ID strings or tables with "id" and "size" keys
      {
        id = "scopes", -- variable scopes
        size = 0.25, -- Can be float or integer > 1
      },
      { id = "breakpoints", size = 0.25 },
      { id = "stacks", size = 0.25 }, -- threads and stack frames
      -- Allows creation of expressions to watch the value of in the context of the current frame.
      -- This uses a prompt buffer for input.
      -- To enter a new expression, just enter insert mode and you will see a prompt appear. Press enter to submit
      { id = "watches", size = 00.25 },
    },
    size = 40,
    position = "left", -- Can be "left", "right", "top", "bottom"
  },
  tray = {
    elements = { "repl" },
    size = 10,
    position = "bottom", -- Can be "left", "right", "top", "bottom"
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
}

local virtual_config = {
  -- enable this plugin (the default)
  enabled = true,
  -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle,
  -- (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
  enabled_commands = true,
  -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
  highlight_changed_variables = true,
  -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
  highlight_new_as_changed = false,
  -- show stop reason when stopped for exceptions
  show_stop_reason = true,
  -- prefix virtual text with comment string
  commented = false,

  -- experimental features:
  -- position of virtual text, see `:h nvim_buf_set_extmark()`
  virt_text_pos = "eol",
  -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
  all_frames = false,
  -- show virtual lines instead of virtual text (will flicker!)
  virt_lines = false,
  -- position the virtual text at a fixed window column (starting from the first text column) ,
  -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
  virt_text_win_col = nil,
}

local breakpoint = {
  text = "",
  texthl = "LspDiagnosticsSignError",
  linehl = "",
  numhl = "",
}
local breakpoint_rejected = {
  text = "",
  texthl = "LspDiagnosticsSignHint",
  linehl = "",
  numhl = "",
}
local stopped = {
  text = "",
  texthl = "LspDiagnosticsSignInformation",
  linehl = "DiagnosticUnderlineInfo",
  numhl = "LspDiagnosticsSignInformation",
}

-- nvim-dap-ui is built on the idea of "elements". These elements are windows which provide different features.
local function add_ui()
  local ok, ui = pcall(require, "dapui")
  if not ok then
    return
  end

  ui.setup(ui_config)

  local dap = require "dap"
  dap.listeners.after.event_initialized["dapui_config"] = function()
    ui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    ui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    ui.close()
  end

  -- stylua: ignore start
  -- KEY: DAP UI
  -- related to toggle: close and open
  rel_add("t", ui.toggle, "Toggle the UI")
  -- r and y are surrounding t
  rel_add("r", function() ui.toggle("sidebar") end, "Toggle the Sidebar of the UI")
  rel_add("y", function() ui.toggle("tray") end, "Toggle the Tray of the UI")
  rel_add("q", ui.close, "Close the UI")
  rel_add("o", ui.open, "Open the UI")
  -- stylua: ignore end

  -- Elements can also be displayed temporarily in a floating window.
  -- Call the same function again while the window is open and the cursor will jump to the floating window.
  -- The REPL will automatically jump to the floating window on open.
  -- require("dapui").float_element(<element ID>, <optional settings>)
  rel_add("w", ui.float_element, "Float a UI Element temporarily. With prompt")
  rel_add("e", ui.eval, "Show result of evaluating an expression")
end

local function add_virtual_text()
  local ok, virtual = pcall(require, "nvim-dap-virtual-text")
  if not ok then
    return
  end

  virtual.setup(virtual_config)
end

local function add_repl_completion()
  --[[
nvim-dap includes an omnifunc implementation which uses the active debug
session to get completion candidates.

It is by default set within the REPL which means you can use `CTRL-X CTRL-O` to
trigger completion within the REPL.

You can also setup the completion to trigger automatically:
  au FileType dap-repl lua require('dap.ext.autocompl').attach()
--]]

  local dap_group = vim.api.nvim_create_augroup("ak_dap", {})
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "dap-repl",
    callback = function()
      require("dap.ext.autocompl").attach()
    end,
    group = dap_group,
    desc = "dap repl automcompletion",
  })
end

vim.fn.sign_define("DapBreakpoint", breakpoint)
vim.fn.sign_define("DapBreakpointRejected", breakpoint_rejected)
vim.fn.sign_define("DapStopped", stopped)
-- DapLogPoint
-- DapBreakpointCondition defauls to C for conditional breakpoints

-- local dap = require "dap"
-- dap.defaults.fallback.terminal_win_cmd = "50vsplit new"

-- See also: Telescope
-- See also: dap_init
add_repl_completion()
add_virtual_text()
add_ui()
