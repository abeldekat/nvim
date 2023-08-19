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
    -- version = "^1",
    dependencies = { "kevinhwang91/promise-async" },
    event = { "BufReadPost", "BufNewFile", "InsertEnter" },
    init = function()
      vim.keymap.set("n", "zR", function()
        require("ufo").openAllFolds()
      end, { desc = "Opennn all folds" })
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
    opts = { -- copied from astronvim
      provider_selector = function(_, filetype, buftype)
        local function handleFallbackException(bufnr, err, providerName)
          if type(err) == "string" and err:match("UfoFallbackException") then
            return require("ufo").getFolds(bufnr, providerName)
          else
            return require("promise").reject(err)
          end
        end

        return (filetype == "" or buftype == "nofile") and "indent" -- only use indent until a file is opened
          or function(bufnr)
            return require("ufo")
              .getFolds(bufnr, "lsp")
              :catch(function(err)
                return handleFallbackException(bufnr, err, "treesitter")
              end)
              :catch(function(err)
                return handleFallbackException(bufnr, err, "indent")
              end)
          end
      end,
    },
  },
}
