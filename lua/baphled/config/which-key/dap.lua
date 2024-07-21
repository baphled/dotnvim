local which_key = require("which-key")

which_key.add({
  {
    "<F10>",
    "<cmd>lua require('dap').step_out()<cr>",
    desc = "DAP Step Out",
    nowait = false,
    remap = false
  },
  {
    "<F7>",
    "<cmd>lua require('dap').continue()<cr>",
    desc = "DAP Continue",
    nowait = false,
    remap = false
  },
  {
    "<F8>",
    "<cmd>lua require('dap').step_over()<cr>",
    desc = "DAP Step Over",
    nowait = false,
    remap = false
  },
  {
    "<F9>",
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
  {
    "C-D",
    function()
      require('dap').continue()
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false) -- Spaces buffers evenly
    end,
    desc = "Start",
    nowait = false,
    remap = false
  },
})
