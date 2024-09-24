local which_key = require("which-key")

which_key.add({
  {
    "<leader>Y",
    [["+Y]],
    mode = { "v" },
    desc = "Copy Line to System Clipboard"
  },
  {
    "<leader>y",
    [["+y]],
    desc = "System to Clipboard",
    mode = { "n" }
  },
  {
    "<leader>p",
    '"_dP',
    mode = { "n", "v" },
    desc = "Paste and retain previous register"
  },
  {
    "<leader>d",
    '"_d',
    desc = "Delete Line"
  },
  {
    "<Down>",
    "<Nop>",
    desc = "Disable Down",
    nowait = false,
    remap = false,
    mode = { "n", "v" }
  },
  {
    "<Left>",
    "<Nop>",
    desc = "Disable Left",
    nowait = false,
    remap = false,
    mode = { "n", "v" }
  },
  {
    "<Right>",
    "<Nop>",
    desc = "Disable Right",
    nowait = false,
    remap = false,
    mode = { "n", "v" }
  },
  {
    "<Up>",
    "<Nop>",
    desc = "Disable Up",
    nowait = false,
    remap = false,
    mode = { "n", "v" }
  },
  {
    "<leader>s",
    group = "Search & Replace",
  },
  {
    "<leader>ss",
    ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
    desc = "Search and Replace",
    nowait = false,
    remap = false
  },
  {
    "<cr>",
    "<cmd>nohlsearch<CR>",
    desc = "Disable Highlighting",
    nowait = false,
    remap = false,
    mode = "n",
  },
  {
    "<leader>l",
    group = "Lines",
  },
  {
    "<leader>ln",
    group = "Line Numbers",
    nowait = false,
    remap = false,
    mode = "n",
  },
  {
    "<leader>lc",
    "<cmd>set cursorline!<CR>",
    desc = "Cursorline",
    nowait = false,
    remap = false,
    mode = "n",
  },
  {
    "<leader>lh",
    "<cmd>set hlsearch!<CR>",
    desc = "Highlight",
    nowait = false,
    remap = false,
    mode = "n",
  },
  {
    "<leader>ln",
    "<cmd>set number!<CR>",
    desc = "Number",
    nowait = false,
    remap = false,
    mode = "n",
  },
  {
    "<leader>lr",
    "<cmd>set relativenumber!<CR>",
    desc = "Relative Number",
    nowait = false,
    remap = false,
    mode = "n",
  },
})
