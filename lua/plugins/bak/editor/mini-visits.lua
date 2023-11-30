return {
  {
    "echasnovski/mini.visits",
    keys = {
      {
        "<Leader>vy",
        function()
          local make_select_path = function(select_global, recency_weight)
            local visits = require("mini.visits")
            local sort = visits.gen_sort.default({ recency_weight = recency_weight })
            local select_opts = { sort = sort }
            return function()
              local cwd = select_global and "" or vim.fn.getcwd()
              visits.select_path(cwd, select_opts)
            end
          end
          make_select_path(true, 0.5)()
        end,
        "Select frecent (all)",
      },
    },
    opts = function()
      return {
        -- How visit index is converted to list of paths
        list = {
          -- Predicate for which paths to include (all by default)
          filter = nil,
          -- Sort paths based on the visit data (robust frecency by default)
          sort = nil,
        },
        -- Whether to disable showing non-error feedback
        silent = false,
        -- How visit index is stored
        store = {
          -- Whether to write all visits before Neovim is closed
          autowrite = true,
          -- Function to ensure that written index is relevant
          normalize = nil,
          -- Path to store visit index
          path = vim.fn.stdpath("data") .. "/mini-visits-index",
        },
        -- How visit tracking is done
        track = {
          -- Start visit register timer at this event
          -- Supply empty string (`''`) to not do this automatically
          event = "BufEnter",
          -- Debounce delay after event to register a visit
          delay = 2000, -- 1000,
        },
      }
    end,
    config = function(_, opts)
      require("mini.visits").setup(opts)

      local make_select_path = function(select_global, recency_weight)
        local visits = require("mini.visits")
        local sort = visits.gen_sort.default({ recency_weight = recency_weight })
        local select_opts = { sort = sort }
        return function()
          local cwd = select_global and "" or vim.fn.getcwd()
          visits.select_path(cwd, select_opts)
        end
      end
      local map = function(lhs, desc, ...)
        vim.keymap.set("n", lhs, make_select_path(...), { desc = desc })
      end

      -- Adjust LHS and description to your liking
      map("<Leader>vr", "Select recent (all)", true, 1)
      map("<Leader>vR", "Select recent (cwd)", false, 1)
      -- map("<Leader>vy", "Select frecent (all)", true, 0.5)
      map("<Leader>vY", "Select frecent (cwd)", false, 0.5)
      map("<Leader>vf", "Select frequent (all)", true, 0)
      map("<Leader>vF", "Select frequent (cwd)", false, 0)

      ----------------------------
      -- Example use manual labels:
      local map_vis = function(keys, call, desc)
        local rhs = "<Cmd>lua MiniVisits." .. call .. "<CR>"
        vim.keymap.set("n", "<Leader>" .. keys, rhs, { desc = desc })
      end

      map_vis("vv", "add_label()", "Add label")
      map_vis("vV", "remove_label()", "Remove label")
      map_vis("vl", 'select_label("", "")', "Select label (all)")
      map_vis("vL", "select_label()", "Select label (cwd)")

      ----------------------------
      -- Example use fixed labels:
      -- Create and select
      -- map_vis("vv", 'add_label("core")', "Add to core")
      -- map_vis("vV", 'remove_label("core")', "Remove from core")
      -- map_vis("vc", 'select_path("", { filter = "core" })', "Select core (all)")
      -- map_vis("vC", 'select_path(nil, { filter = "core" })', "Select core (cwd)")
      --
      -- -- Iterate based on recency
      -- local map_iterate_core = function(lhs, direction, desc)
      --   local opts = { filter = "core", sort = sort_latest, wrap = true }
      --   local rhs = function()
      --     MiniVisits.iterate_paths(direction, vim.fn.getcwd(), opts)
      --   end
      --   vim.keymap.set("n", lhs, rhs, { desc = desc })
      -- end
      --
      -- map_iterate_core("[{", "last", "Core label (earliest)")
      -- map_iterate_core("[[", "forward", "Core label (earlier)")
      -- map_iterate_core("]]", "backward", "Core label (later)")
      -- map_iterate_core("]}", "first", "Core label (latest)")
    end,
  },
}
