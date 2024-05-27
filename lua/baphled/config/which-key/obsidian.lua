local which_key = require("which-key")

local normal_opts = {
  mode = "n",
  prefix = "",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

local obsidian_mapping = {
  ["<leader>"] = {
    o = {
      name = "Obsidian",
      d = { "<cmd>ObsidianDailies<CR>", "Obsidian Dailies" },
      f = { "<cmd>ObsidianFollowLink<CR>", "Obsidian Follow Links" },
      l = { "<cmd>ObsidianLinks<CR>", "Obsidian Links" },
      n = { "<cmd>ObsidianNew<CR>", "Obsidian New" },
      s = { "<cmd>ObsidianSearch<CR>", "Obsidian Search" },
    t = { "<cmd>ObsidianTemplate<CR>", "Use Obsidian Template" },
    },
  },
  f = {
    name = "Obsidian",
    n = { "<cmd>ObsidianQuickSwitch<CR>", "Find Obsidian Notes" },
    t = { "<cmd>ObsidianTags<CR>", "Obsidian Tags" },
  }
}

which_key.register(obsidian_mapping, normal_opts)
