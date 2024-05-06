local mocha = require("catppuccin.palettes").get_palette "mocha"

require('bufferline').setup {
  highlights = require("catppuccin.groups.integrations.bufferline").get {
    styles = { "italic", "bold" },
    custom = {
      mocha = {
        background = { fg = mocha.text },
      },
    },
  },
  options = {
    indicator = {
      icon = '|', -- this should be omitted if indicator style is not 'icon'
      style = 'sloped_tabs',
    },
    mode = 'tabs',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    separator_style = "thin",
  }
}
