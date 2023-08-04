-- customise the trouble plugin

require("trouble").setup {
  height = 10,
  icons = true,
  mode = "document_diagnostics",
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
    jump = {"<cr>", "<tab>"},
    toggle_mode = "m",
    toggle_preview = "P",
    preview = "p",
    close_folds = {"zM", "zm"},
    open_folds = {"zR", "zr"},
    toggle_fold = {"zA", "za"},
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

vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
  {silent = true, noremap = true}
)

vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist<cr>",
  {silent = true, noremap = true}
)

vim.keymap.set("n", "<leader>xq", "<cmd>Trouble quickfix<cr>",
  {silent = true, noremap = true}
)
