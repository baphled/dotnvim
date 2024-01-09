local which_key = require("which-key")

local normal_opts = {
  mode = "n",
  prefix = "",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

local dap_mappings = {
  ["<F7>"] = { "<cmd>lua require('dap').continue()<cr>", "DAP Continue" },
  ["<F8>"] = { "<cmd>lua require('dap').step_over()<cr>", "DAP Step Over" },
  ["<F9>"] = { "<cmd>lua require('dap').step_into()<cr>", "DAP Step Into" },
  ["<F10>"] = { "<cmd>lua require('dap').step_out()<cr>", "DAP Step Out" },
  ["C-D"] = {
    function()
      require('dap').continue()
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false) -- Spaces buffers evenly
    end,
    "Start"
  },
  ['<leader>'] = {
    b = {
      "<cmd>lua require('dap').toggle_breakpoint()<cr>",
      "Toggle Breakpoint"
    },
    B = {
      "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
      "Set Breakpoint"
    },
  },
}

which_key.register(dap_mappings, normal_opts)
