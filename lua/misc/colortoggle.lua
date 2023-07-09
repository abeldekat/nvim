local M = {}

function M.add_toggle(opts)
  local current = 1
  vim.keymap.set("n", opts.key and opts.key or "<leader>a", function()
    current = current == #opts.flavours and 1 or (current + 1)
    local flavour = opts.flavours[current]

    opts.toggle(flavour)
    local flavour_info = flavour
    if type(flavour) == "table" then
      flavour_info = string.format("%s%s%s", flavour[2], flavour[2] ~= "" and "-" or "", flavour[1])
    end
    local info = string.format("Using %s[%s]", flavour_info, opts.name)

    vim.defer_fn(function()
      vim.api.nvim_echo({ { info, "InfoMsg" } }, true, {})
    end, 250)
  end, { desc = "Toggle Theme Colors" })
end

return M
