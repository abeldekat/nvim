-- npm install -g @ansible/ansible-language-server
-- https://github.com/ansible/ansible-language-server
-- https://github.com/yaegassy/coc-ansible

-- # interesting:https://github.com/pearofducks/ansible-vim
-- augroup ansible_vim_ftyaml_ansible
--     au!
--     au BufNewFile,BufRead * if s:isAnsible() | set ft=yaml.ansible | en
-- augroup END
-- augroup ansible_vim_ftjinja2
--     au!
--     au BufNewFile,BufRead *.j2 call s:setupTemplate()
-- augroup END
-- augroup ansible_vim_fthosts
--     au!
--     au BufNewFile,BufRead hosts set ft=ansible_hosts
-- augroup END

-- lsp installer:
-- cmd = { "node", path.concat { root_dir, "out", "server", "src", "server.js" }, "--stdio" },

-- lsp config:
-- local bin_name = 'ansible-language-server'
-- local cmd = { bin_name, '--stdio' }
-- --> There is no node_modules/.bin

local handlers = require "ak.lsp.handlers"
local opts = {
  capabilities = handlers.capabilities(),
  on_attach = function(client, bufnr)
    handlers.on_attach(client, bufnr)
    handlers.on_attach_formatting_opt_out(client, bufnr)
  end,
  settings = {
    ansible = {
      -- TODO no ansible completion
      -- https://github.com/ansible/ansible-language-server/issues/391
      completion = {
        provideRedirectModule = false,
      },
      python = {
        interpreterPath = "python",
      },
      ansibleLint = {
        path = "ansible-lint",
        enabled = true,
      },
      ansible = {
        path = "ansible",
        useFullyQualifiedCollectionNames = true,
      },
      executionEnvironment = {
        enabled = false,
      },
    },
  },
}

return opts
