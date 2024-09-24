require("baphled.config.which-key.init")

local which_key = require("which-key")

which_key.setup({
  win = {
    border = "rounded",
  },
  triggers = {
    { "<auto>", mode = "nixsotc" },
    { "<leader>", mode = "nixsotc" },
    { "t", mode = "n" },
    { "g", mode = "n" },
  },
})
