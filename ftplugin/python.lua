--https://github.com/microsoft/debugpy
--[[
It is recommended to install debugpy into a dedicated virtualenv. To do so:

```bash
mkdir .virtualenvs
cd .virtualenvs
python -m venv debugpy
debugpy/bin/python -m pip install debugpy
```

The debugger will automatically pick-up another virtual environment if it is
activated before neovim is started.

--]]

-- dap-python needs a path... Taken from DAPInstall
local dbg_path = vim.fn.stdpath "data" .. "/dapinstall/"
local function python_path()
  local venv_path = os.getenv "VIRTUAL_ENV"
  if venv_path then
    return venv_path .. "/bin/python"
  end
  if vim.fn.executable(dbg_path .. "bin/python") == 1 then
    return dbg_path .. "bin/python"
  else
    return "/usr/bin/python"
  end
end

-- COMMAND:
vim.api.nvim_create_user_command("ActivateDapForPython", function()
  require "dap" -- triggers packer lazy load
  require("dap-python").setup(python_path())
end, { desc = "Lazy load DAP by requiring its module. Setup python DAP." })

--[[
dap help:
    lua << EOF
    local dap = require('dap')
    dap.adapters.python = {
      type = 'executable';
      command = os.getenv('HOME') .. '/.virtualenvs/tools/bin/python';
      args = { '-m', 'debugpy.adapter' };
    }
    EOF
--]]
