-- dap can be lazy loaded on module = "dap"
local name = "nvim-dap"
local optional_installs = require "ak.core.optional_installs"
if not optional_installs.is_installed(name, "dap") then
  return
end

-- KEY: DAP
local dap_keyprefix = "<leader>D"

-- helpers:
local set = vim.keymap.set
local add = function(lhs, rhs, desc)
  set("n", lhs, rhs, { desc = "DAP " .. desc })
end
local dap_add = function(lhs, rhs, desc)
  add(dap_keyprefix .. lhs, rhs, desc)
end

-- KEY: DAP
-- mnemonic as the keys get bigger the jump is bigger, f1,f2,f3

local function step_back()
  require("dap").step_back()
end
dap_add("b", step_back, "Step Back")

local function toggle_breakpoint()
  require("dap").toggle_breakpoint()
end
dap_add("t", toggle_breakpoint, "Toggle Breakpoint")

local function set_breakpoint()
  require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ")
end
dap_add("T", set_breakpoint, "Set Conditional Breakpoint")

local function continue()
  require("dap").continue()
end
dap_add("c", continue, "Continue")
add("<F5>", continue, "Continue")

local function run_to_cursor()
  require("dap").run_to_cursor()
end
dap_add("C", run_to_cursor, "Run to cursor")

local function disconnect()
  require("dap").disconnect()
end
dap_add("d", disconnect, "Disconnect")

local function session()
  require("dap").session()
end
dap_add("g", session, "Get Session")

local function step_into()
  require("dap").step_into()
end
dap_add("i", step_into, "Step Into")
add("<F1>", step_into, "Step Into")

local function step_over()
  require("dap").step_over()
end
dap_add("o", step_over, "Step Over")
add("<F2>", step_over, "Step Over")

local function step_out()
  require("dap").step_out()
end
dap_add("u", step_out, "Step Out")
add("<F3>", step_out, "Step Out")

local function pause_toggle()
  require("dap").pause.toggle()
end
dap_add("p", pause_toggle, "Pause Toggle")

local function repl_toggle()
  require("dap").repl.toggle()
end
dap_add("r", repl_toggle, "Repl Toggle")

local function start()
  require("dap").continue()
end
dap_add("s", start, "Start")

local function quit()
  require("dap").close()
end
dap_add("q", quit, "Quit")

-- TODO
-- nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
-- nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>
