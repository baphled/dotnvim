local settings = {
  -- every line should be same width without escaped \
  header = {
    type = "text",
    align = "center",
    fold_section = false,
    title = "Header",
    margin = 5,
    content = require("baphled.startup.headers").boodah_header,
    highlight = "TSString",
    default_color = "#FFFFFF",
  },
  quote = {
    type = "text",
    oldfiles_directory = false,
    align = "center",
    fold_section = false,
    title = "Quote",
    margin = 5,
    content = require("startup.functions").quote(),
    highlight = "Constant",
    default_color = "",
  },
  -- name which will be displayed and command
  navigation = {
    type = "mapping",
    align = "center",
    fold_section = true,
    title = "Basic Commands",
    margin = 5,
    content = {
      { " Find File", "Telescope find_files", "<leader>ff" },
      { " Find Word", "Telescope live_grep", "<leader>lg" },
      { " Branches", "Telescope git_branches", "<C-g>" },
      { " File Browser", "Oil --float", "<leader>nt" },
      { " New File", "lua require'startup'.new_file()", "<leader>nf" },
    },
    highlight = "String",
    default_color = "",
  },

  colors = {
    background = "#1f2227",
    folded_section = "#56b6c2",
  },
  parts = {
    "header",
    "quote",
    "navigation",
  },
}
return settings
