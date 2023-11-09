return {

  {
    "nvim-neotest/neotest",
    -- opts = function(_, opts)
    --   opts.adapters["neotest-python"] = {
    --     dap = { justMyCode = false },
    --     -- runner = "pytest",
    --     -- args = { "--log-level", "DEBUG" },
    --   }
    -- end,
    keys = {
      {
        "<leader>ta",
        function()
          for _, adapter_id in ipairs(require("neotest").run.adapters()) do
            require("neotest").run.run({ suite = true, adapter = adapter_id })
          end
        end,
        desc = "Test Suite",
      },
      {
        "<leader>tl",
        function()
          require("neotest").run.run_last()
        end,
        desc = "Test Last",
      },
      { -- existing, adding extra_args
        "<leader>tr",
        function()
          require("neotest").run.run({ extra_args = { "-s", "-vvv" } })
        end,
        desc = "Test Nearest",
      },
    },
  },

  {
    "telescope.nvim",
    optional = true,
    dependencies = {
      {
        "otavioschwanck/telescope-alternate.nvim",
        keys = {
          {
            "me",
            ":Telescope telescope-alternate alternate_file<cr>",
            desc = "Alternate file",
          },
        },
        opts = {
          mappings = {
            {
              "src/(.*)/(.*).py",
              { { "tests/**/test_[2].py", "Test", false } },
            },
            {
              "tests/(.*)/test_(.*).py",
              { { "src/**/[2].py", "Source", false } },
            },
          },
        },
        config = function(_, opts)
          require("telescope-alternate").setup(opts)
          require("telescope").load_extension("telescope-alternate")
        end,
      },
    },
  },

  -- NOTE: Projectionist could be used project specific: .projections.json
  --
  -- {
  --   "tpope/vim-projectionist",
  --   lazy = true,
  --   keys = {
  --     {
  --       "me",
  --       function()
  --         -- bufreadpost triggers commands in the current buffer
  --         vim.api.nvim_exec_autocmds("BufReadPost", {})
  --         vim.cmd("A")
  --       end,
  --       desc = "Alternate file",
  --     },
  --   },
  -- },

  -- {
  --   "vim-test/vim-test",
  --   keys = {
  --     {
  --       "<leader>tt",
  --       function()
  --         return vim.cmd("TestNearest")
  --       end,
  --       desc = "Test nearest",
  --     },
  --     {
  --       "<leader>tT",
  --       function()
  --         return vim.cmd("TestFile")
  --       end,
  --       desc = "Test file",
  --     },
  --     {
  --       "<leader>ta",
  --       function()
  --         return vim.cmd("TestSuite")
  --       end,
  --       desc = "Test suite",
  --     },
  --     {
  --       "<leader>tl",
  --       function()
  --         return vim.cmd("TestLast")
  --       end,
  --       desc = "Test last",
  --     },
  --     {
  --       "<leader>tg",
  --       function()
  --         return vim.cmd("TestVisit")
  --       end,
  --       desc = "Test visit",
  --     },
  --   },
  --   config = function()
  --     -- vim.g["test#strategy"] = "neovim"
  --     vim.g["test#strategy"] = "harpoon"
  --     vim.g["test#python#runner"] = "pytest"
  --     -- Nearest should be as verbose as possible
  --     vim.g["test#python#pytest#options"] = {
  --       nearest = "-s -vvv",
  --     }
  --     vim.g["test#enabled_runners"] = { "python#pytest" }
  --
  --     -- Test wrapper for pytest? The commands do not show up
  --     -- let g:test#runner_commands = ['Minitest', 'Mocha']
  --
  --     -- if projectionist.vim is present, you can run a test command from an application file,
  --     -- and test.vim will automatically try to run the command on the "alternate" test file.
  --   end,
  -- },
}
