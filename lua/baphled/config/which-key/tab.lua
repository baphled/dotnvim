local which_key = require("which-key")
local utils = require("baphled.utils")

local normal_opts = {
  mode = "n",
  prefix = "",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

local tab_mapping = {
  ['<leader>'] = {
    ["<Down>"] = {
      function()
        utils.move_window_in_tab()
      end,
      "Move to New Tab"
    },
  }
}

which_key.register(tab_mapping, normal_opts)

