local trouble = require("trouble.sources.telescope")
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
        ["<c-t>"] = trouble.open,
        ["<c-w>"] = "which_key",
        ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
        ["<C-cr>"] = require("telescope-undo.actions").restore,
        -- alternative defaults, for users whose terminals do questionable things with modified <cr>
        ["<C-y>"] = require("telescope-undo.actions").yank_deletions,
        ["<C-r>"] = require("telescope-undo.actions").restore,
      },
      n = {
        ["<c-t>"] = trouble.open,
        ["y"] = require("telescope-undo.actions").yank_additions,
        ["Y"] = require("telescope-undo.actions").yank_deletions,
        ["u"] = require("telescope-undo.actions").restore,
      },
    },
  },
}

require("telescope").load_extension("lazygit")
require("telescope").load_extension("undo")
