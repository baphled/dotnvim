local which_key = require("which-key")

which_key.add({
  {
    "<leader>e",
    "<cmd>MoltenEvaluateOperator<cr>",
    desc = "evaluate operator",
    nowait = false,
    remap = false
  },
  {
    "<leader>mc",
    "<cmd>MoltenReevaluateCell<CR>",
    desc = "evaluate cell",
    nowait = false,
    remap = false
  },
  {
    "<leader>md",
    "<cmd>MoltenDelete<cr>",
    desc = "delete Molten cell",
    nowait = false,
    remap = false
  },
  {
    "<leader>mh",
    "<cmd>MoltenHideOutput<cr>",
    desc = "close output window",
    nowait = false,
    remap = false
  },
  {
    "<leader>ml",
    "<cmd>MoltenEvaluateLine<CR>",
    desc = "evaluate line",
    nowait = false,
    remap = false
  },
  {
    "<leader>ms",
    "<cmd>noautocmd MoltenEnterOutput<cr>",
    desc = "open output window",
    nowait = false,
    remap = false
  },
  {
    "<leader>mx",
    "<cmd>MoltenOpenInBrowser<cr>",
    desc = "open output in browser",
    nowait = false,
    remap = false
  },
  {
    "<leader>mr",
    ":<C-u>MoltenEvaluateVisual<CR>gv",
    desc = "execute visual selection",
    mode = "v",
    nowait = false,
    remap = false
  },
})
