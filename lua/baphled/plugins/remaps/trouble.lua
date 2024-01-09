local which_key = require("which-key")

local normal_opts = {
  mode = "n",
  prefix = "",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

local trouble_mapping = {
  ['<leader>'] = {
    x = {
      d = { "<cmd>Trouble document_diagnostics<cr>", "Find Document Diagnostics" },
      w = { "<cmd>Trouble workspace_diagnostics<cr>", "Find Workspace Diagnostics" },
      x = { "<cmd>TroubleToggle<cr>", "Toggle Trouble" },
    },
  }
}

which_key.register(trouble_mapping, normal_opts)
