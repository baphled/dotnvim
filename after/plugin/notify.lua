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
  time_formats = {
    notification_history = "%FT%T",
    notification = "%T",
  },
})

vim.notify = require("notify")

require('lsp-notify').setup({
})
