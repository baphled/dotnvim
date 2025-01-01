require("edgy").setup {
  animate = { enabled = false },
  options = {
    top = { size = 10 },
  },
  bottom = {
    {
      ft = "snacks_terminal",
      size = { height = 20 },
      title = "Terminal %{b:snacks_terminal.id}",
      filter = function(_buf, win)
        return vim.w[win].snacks_win
            and vim.w[win].snacks_win.position == "bottom"
            and vim.w[win].snacks_win.relative == "editor"
            and not vim.w[win].trouble_preview
      end,
    },
    { ft = "qf", title = "QuickFix" },
    {
      ft = "dap_repl",
      title = "DAP Repl",
      size = { height = 20 },
    },
    { ft = "trouble_quickfix", title = "QuickFix (Trouble)", size = { height = 10 } },
  },
  top = {
    { title = "Neotest Output", ft = "neotest-output-panel", size = { height = 10 } },
  },
  left = {
    { ft = "codecompanion",     title = "Code Companion",  size = { width = 0.3 } },
    { ft = "neotest-summary", title = "Neotest Summary", size = { width = 0.2 } },
    { ft = "dapui_watches",     title = "DAP Watches",     size = { width = 0.2 } },
    { ft = "dapui_stacks",      title = "DAP Stacks",      size = { width = 0.2 } },
    { ft = "dapui_breakpoints", title = "DAP Breakpoints", size = { width = 0.2 } },
    { ft = "dapui_scopes",      title = "DAP Scopes",      size = { width = 0.2 } },
    { ft = "query",      title = "Treesitter Query",      size = { width = 0.3 } },
  },
  right = {
    { ft = "trouble_symbols", title = "Symbols (Trouble)", size = { width = 0.2 } },
    { ft = "trouble_lsp", title = "LSP (Trouble)", size = { width = 0.2 } },
  },
}
