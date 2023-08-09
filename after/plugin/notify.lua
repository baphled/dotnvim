require("notify").setup({
  stages = "fade_in_slide_out",
  -- default timeout for notifications
  timeout = 5000,
  -- For stages that change opacity this is treated as the highlight behind the window
  background_colour = "#000000",
  -- Icons for the different levels
  icons = {
    spinners = { '⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷' },
    ERROR    = "",
    WARN     = "",
    INFO     = "",
    DEBUG    = "",
    TRACE    = "✎",
    FATAL    = "",
  },
})
require('lsp-notify').setup({
  notify = require('notify'),
  icons = {
    spinners = { '⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷' },
    done     = '',
  },
})

vim.notify = require("notify")
