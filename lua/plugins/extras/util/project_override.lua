return {
  {
    "telescope.nvim",
    dependencies = {
      { -- only load on key
        "ahmedkhalf/project.nvim",
        event = function()
          return {}
        end,
      },
    },
  },
}
