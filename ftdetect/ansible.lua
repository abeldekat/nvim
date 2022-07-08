-- function! s:isAnsible()
--   let filepath = expand("%:p")
--   let filename = expand("%:t")
--   if filepath =~ '\v/(tasks|roles|handlers)/.*\.ya?ml$' | return 1 | en
--   if filepath =~ '\v/(group|host)_vars/' | return 1 | en
--   let s:ftdetect_filename_regex = '\v(playbook|site|main|local|requirements)\.ya?ml$'
--   if exists("g:ansible_ftdetect_filename_regex")
--     let s:ftdetect_filename_regex = g:ansible_ftdetect_filename_regex
--   endif

--   if filename =~ s:ftdetect_filename_regex | return 1 | en

--   let shebang = getline(1)
--   if shebang =~# '^#!.*/bin/env\s\+ansible-playbook\>' | return 1 | en
--   if shebang =~# '^#!.*/bin/ansible-playbook\>' | return 1 | en

--   return 0
-- endfunction

-- either by extension or filename(either the "tail" or the full file path)
vim.filetype.add {
  extension = {},
  filename = {
    -- ["setup.yml"] = "yaml.ansible",
    -- ["config.yml"] = "yaml.ansible",
    -- ["main.yml"] = "yaml.ansible",
    -- ["input.yml"] = "yaml.ansible",
    -- ["cloud.yml"] = "yaml.ansible",
    -- ["users.yml"] = "yaml.ansible",
    -- ["server.yml"] = "yaml.ansible",
  },
  pattern = {
    -- tasks, handlers
    [".*/playbooks/.+%.ya?ml"] = "yaml.ansible",
    -- [".*/roles/.+%.ya?ml"] = "yaml.ansible",
    -- [".*/group_vars/.*"] = "yaml.ansible",
    -- [".*/host_vars/.*"] = "yaml.ansible",
  },
}
