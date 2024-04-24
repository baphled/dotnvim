local trouble = require("trouble.providers.telescope")
local telescope = require("telescope")

telescope.setup {
  defaults = {
    layout_config = {
      prompt_position = "bottom",
      horizontal = {
        width_padding = 0.1,
        height_padding = 0.1,
        preview_width = 0.6,
      },
    },
    mappings = {
      i = {
        ["<c-t>"] = trouble.open_with_trouble,
        ["<c-w>"] = "which_key",
      },
      n = { ["<c-t>"] = trouble.open_with_trouble },
    },
  },
}
