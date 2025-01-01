require("baphled.config.which-key.init")

local which_key = require("which-key")

which_key.setup({
  win = {
    border = "rounded",
  },
  triggers = {
    { "<auto>", mode = "nixsotc" },
    { "<leader>", mode = "nixsotc" },
    { "<localleader>", mode = "nixsotc" },
    { "<M-a>", mode = "n" },
    { "<C-w>", mode = "n" },
    { "d", mode = "n" },
    { "t", mode = "n" },
    { "f", mode = "n" },
    { "g", mode = "n" },
  },
})
