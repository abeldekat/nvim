local mapper = require "ak.telescope.mapper"

-- KEYS: telescope files: find_files, oldfiles, gitfiles, buffers

local function set_prompt_to_entry_value(prompt_bufnr)
  local action_state = require "telescope.actions.state"
  local entry = action_state.get_selected_entry()
  if not entry or not type(entry) == "table" then
    return
  end

  action_state.get_current_picker(prompt_bufnr):reset_prompt(entry.ordinal)
end

local function find_files()
  local opts = require("telescope.themes").get_dropdown {
    previewer = false,
  }
  require("telescope.builtin").find_files(opts)
end
mapper.map("<leader>e", find_files, "Find files")

local function git_files()
  local opts = require("telescope.themes").get_dropdown {
    previewer = false,
  }
  require("telescope.builtin").git_files(opts)
end
mapper.map("<leader>fg", git_files, "Find git files")

local function find_all_files()
  local opts = require("telescope.themes").get_ivy {}
  require("telescope.builtin").fd(opts)
end
mapper.map("<leader>fa", find_all_files, "Find all files hidden inclusive")

local function find_directories()
  require "ak.telescope.custom.directories"()
end
mapper.map("<leader>fd", find_directories, "Find directories, using fdfind. With lir, remember the @ sign to cwd")

local function files_rg_by_type()
  require("telescope.builtin").find_files {
    find_command = {
      "rg",
      "--files",
      "--type",
      vim.fn.input "Type: ",
    },
  }
end
mapper.map("<leader>fx", files_rg_by_type, "Find files ripgrep with specific type")

-- also candidate fi
local function files_rg_with_git_ignored()
  require("telescope.builtin").find_files {
    find_command = { "rg", "--no-ignore", "--files" },
  }
end
mapper.map("<leader>fz", files_rg_with_git_ignored, "Find files ripgrep no-ignore")

local function installed_plugins()
  require("telescope.builtin").find_files {
    -- cwd = vim.fn.stdpath "data" .. "/site/pack/packer/start/",
    cwd = vim.fn.stdpath "data" .. "/site/pack/packer/",
  }
end
mapper.map("<leader>fP", installed_plugins, "Installed plugins")

local function colors()
  vim.cmd [[colorscheme]]

  local actions = require "telescope.actions"
  local action_state = require "telescope.actions.state"
  local cwd = "~/.config/nvim/lua/ak/colors"
  local opts = require("telescope.themes").get_ivy {
    prompt_title = "~ neovim color plugins ~",
    shorten_path = false,
    cwd = cwd,
    attach_mappings = function(_, _)
      actions.select_default:replace(function()
        local entry = action_state.get_selected_entry()
        vim.cmd("source " .. cwd .. "/" .. entry.value)
        vim.defer_fn(function()
          vim.api.nvim_echo({ { string.format("New colorscheme: [%s]", entry.value), "InfoMsg" } }, false, {})
        end, 250)
      end)
      return true
    end,
  }
  require("telescope.builtin").find_files(opts)
end
mapper.map("<leader>n", colors, "Apply color configurations from neovim config")

local function neovim_config()
  local opts = {
    prompt_title = "~ neovim config ~",
    shorten_path = false,
    cwd = "~/.config/nvim",

    layout_strategy = "flex",
    layout_config = {
      width = 0.9,
      height = 0.8,

      horizontal = {
        width = { padding = 0.15 },
      },
      vertical = {
        preview_height = 0.75,
      },
    },
    mappings = {
      i = {
        ["<C-y>"] = false,
      },
    },

    attach_mappings = function(_, map)
      map("i", "<c-y>", set_prompt_to_entry_value)
      return true
    end,
  }
  require("telescope.builtin").find_files(opts)
end
mapper.map("<leader>fv", neovim_config, "Find files in neovim config")
