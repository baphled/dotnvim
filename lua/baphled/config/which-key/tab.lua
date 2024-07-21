local which_key = require("which-key")
local utils = require("baphled.utils")

which_key.add({
  {
    "<leader><Down>",
    function()
      utils.move_window_in_tab()
    end,
    desc = "Move to New Tab",
    nowait = false,
    remap = false
  },
})
