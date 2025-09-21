-- customise the trouble plugin

require("trouble").setup {
  stages = "fade_in_slide_out",
  icons = {
    spinners = { '⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷' },
  },
  background_colour = "#000000",
  height = 10,
  mode = "document_diagnostics",
  preview = {
    enabled = false,
  },
  include_declaration = {
    "definitions",
    "lsp_implementations",
    "lsp_references",
    "lsp_typedefs",
    "document_diagnostics",
    "document_symbols",
    "quickfix",
  },
  fold_open = "",
  fold_closed = "",
  action_keys = {
    close = "q",
    refresh = "r",
    jump = { "<cr>", "<tab>" },
    toggle_mode = "m",
    toggle_preview = "P",
    preview = "p",
    close_folds = { "zM", "zm" },
    open_folds = { "zR", "zr" },
    toggle_fold = { "zA", "za" },
    hover = "K",
    previous = "k",
    next = "j",
  },
  indent_lines = false,
  auto_open = false,
  auto_close = false,
  auto_preview = true,
  auto_fold = true,
  use_diagnostic_signs = true
}
