local which_key = require("which-key")

which_key.add({
  {
    "dso",
    "<cmd>lua require('dap').step_out()<cr>",
    desc = "DAP Step Out",
    nowait = false,
    remap = false
  },
  {
    "dc",
    "<cmd>lua require('dap').continue()<cr>",
    desc = "DAP Continue",
    nowait = false,
    remap = false
  },
  {
    "dss",
    "<cmd>lua require('dap').step_over()<cr>",
    desc = "DAP Step Over",
    nowait = false,
    remap = false
  },
  {
    "dsi",
    "<cmd>lua require('dap').step_into()<cr>",
    desc = "DAP Step Into",
    nowait = false,
    remap = false
  },
  {
    "<leader>B",
    "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
    desc = "Set Breakpoint",
    nowait = false,
    remap = false
  },
  {
    "<leader>b",
    "<cmd>lua require('dap').toggle_breakpoint()<cr>",
    desc = "Toggle Breakpoint",
    nowait = false,
    remap = false
  },
})
