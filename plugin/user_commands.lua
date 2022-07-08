local f = require "pa.invoke"
vim.api.nvim_create_user_command("LoadCoreCollection", f.load_core_collection, {})
vim.api.nvim_create_user_command("LoadCoreCollectionAndColors", f.load_core_collection_and_colors, {})
vim.api.nvim_create_user_command("LoadNiceToHaveCollection", f.load_nth_collection, {})
vim.api.nvim_create_user_command("LoadNiceToHaveCollectionAndColors", f.load_nth_collection_and_colors, {})
vim.api.nvim_create_user_command("LoadColorCollection", f.load_color_collection, {})
vim.api.nvim_create_user_command("LoadAllCollection", f.load_all_collection, {})
