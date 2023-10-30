require("config.lazy")({ -- centralizing settings subject to change
  debug = false,

  dev_patterns = {},
  -- dev_patterns = { "lazyflex" },

  dev_path = "~/projects/lazydev",
  -- dev_path = "~/projects/clone",

  flex = require("flex")({ use = false }), -- use nil to not load the plugin
  -- clone_flex = true, -- useful when starting from scratch
})
