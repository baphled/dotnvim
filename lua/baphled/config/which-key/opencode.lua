local which_key = require("which-key")

which_key.add({
  mode = { "n", "x" },
  noremap = true,
  nowait = false,
  { "<leader>o", group = "opencode" },
  { "<leader>oa", function() require("opencode").ask("@this: ", { submit = true }) end, desc = "Ask opencode" },
  { "<leader>os", function() require("opencode").select() end, desc = "Select opencode action" },
  { "<leader>ot", function() require("opencode").toggle() end, desc = "Toggle opencode" },
  { "<leader>ou", function() require("opencode").command("session.half.page.up") end, desc = "Scroll opencode up" },
  { "<leader>od", function() require("opencode").command("session.half.page.down") end, desc = "Scroll opencode down" },
})

which_key.add({
  mode = "n",
  noremap = true,
  nowait = false,
  { "go", function() return require("opencode").operator("@this ") end, desc = "Add range to opencode", expr = true },
  { "goo", function() return require("opencode").operator("@this ") .. "_" end, desc = "Add line to opencode", expr = true },
})
