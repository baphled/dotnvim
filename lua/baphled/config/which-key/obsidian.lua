local which_key = require("which-key")

which_key.add({
  {
    "<leader>o",
    group = "Obsidian",
    nowait = false,
    remap = false
  },
  {
    "<leader>od",
    "<cmd>ObsidianDailies<CR>",
    desc = "Obsidian Dailies",
    nowait = false,
    remap = false
  },
  {
    "<leader>of",
    "<cmd>ObsidianFollowLink<CR>",
    desc = "Obsidian Follow Links",
    nowait = false,
    remap = false
  },
  {
    "<leader>ol",
    "<cmd>ObsidianLinks<CR>",
    desc = "Obsidian Links",
    nowait = false,
    remap = false
  },
  {
    "<leader>on",
    "<cmd>ObsidianNew<CR>",
    desc = "Obsidian New",
    nowait = false,
    remap = false
  },
  {
    "<leader>os",
    "<cmd>ObsidianSearch<CR>",
    desc = "Obsidian Search",
    nowait = false,
    remap = false
  },
  {
    "<leader>ot",
    "<cmd>ObsidianTemplate<CR>",
    desc = "Use Obsidian Template",
    nowait = false,
    remap = false
  },
  {
    "<leader>ont",
    "<cmd>ObsidianNewFromTemplate<CR>",
    desc = "New From Obsidian Template",
    nowait = false,
    remap = false
  },
  {
    "fn",
    "<cmd>ObsidianQuickSwitch<CR>",
    desc = "Find Obsidian Notes",
    nowait = false,
    remap = false
  },
  {
    "ft",
    "<cmd>ObsidianTags<CR>",
    desc = "Obsidian Tags",
    nowait = false,
    remap = false
  },
})
