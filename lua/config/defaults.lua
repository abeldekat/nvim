return { -- centralizing defaults subject to change
  debug = false,

  dev_patterns = {},
  -- dev_patterns = { "lazyflex" },

  dev_path = "~/projects/lazydev",
  -- dev_path = "~/projects/clone",

  flex = require("flex")({ use = false }), -- use flex=nil to not load the plugin
}
