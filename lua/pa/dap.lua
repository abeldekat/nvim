local result = {
  {
    "Pocco81/DAPInstall.nvim",
    opt = true,
  },

  {
    "mfussenegger/nvim-dap",
    module = "dap",
  },

  {
    "theHamsta/nvim-dap-virtual-text",
    after = "nvim-dap",
  },

  {
    "nvim-telescope/telescope-dap.nvim",
    after = "nvim-dap-virtual-text",
  },
  {
    "rcarriga/nvim-dap-ui",
    after = "telescope-dap.nvim",
    config = function()
      require "ak.dap.setup"
    end,
  },

  {
    "mfussenegger/nvim-dap-python",
    module = "dap-python",
  },
}

return result
