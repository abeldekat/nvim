-- za [a]lternate? toggle under cursor, zA all under cursor
-- zc [c]lose under cursor, zC all under cursor
-- zi [i]nverse? toggle folding
-- zm fold [m]ore zM close all folds
-- zo [o]pen fold under cursor, zO all under cursor
-- zr [r]educe, fold less, zR open all folds
-- zv [v]iew? show cursor line
-- zx update folds
-- zf create [f]old

-- [m]ore folds [c]loses folds
--  [r]educe folding opens folds, thus less folds

-- stylua: ignore start
-- if true then return {} end
-- stylua: ignore end
return {

  {
    "neovim/nvim-lspconfig",
    opts = {
      capabilities = {
        textDocument = {
          foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
          },
        },
      },
    },
  },

  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    event = { "BufReadPost", "BufNewFile", "InsertEnter" },
    init = function()
      vim.opt.foldenable = true
      vim.opt.foldcolumn = "0"
      vim.opt.foldlevel = 99 -- set high foldlevel for nvim-ufo
      vim.opt.foldlevelstart = 99 -- start with all code unfolded

      vim.keymap.set("n", "zR", function()
        require("ufo").openAllFolds()
      end, { desc = "Open all folds" })
      vim.keymap.set("n", "zM", function()
        require("ufo").closeAllFolds()
      end, { desc = "Close all folds" })
      vim.keymap.set("n", "zr", function()
        require("ufo").openFoldsExceptKinds()
      end, { desc = "Fold less" })
      vim.keymap.set("n", "zm", function()
        require("ufo").closeFoldsWith()
      end, { desc = "Fold more" })
      vim.keymap.set("n", "zp", function()
        require("ufo").peekFoldedLinesUnderCursor()
      end, { desc = "Preview folds" })
    end,
    opts = function()
      local ftMap = {
        vim = { "treesitter", "indent" },
      }

      -- https://github.com/kevinhwang91/nvim-ufo/blob/main/doc/example.lua
      return {
        open_fold_hl_timeout = 0,
        -- close_fold_kinds = { "imports" },
        provider_selector = function(bufnr, filetype, buftype)
          return ftMap[filetype] or { "lsp", "indent" }
        end,
      }
    end,
  },
}
