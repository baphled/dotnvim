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
  },
  top = {
    {
      ft = "help",
      size = { height = 20 },
      -- only show help buffers
      filter = function(buf)
        return vim.bo[buf].buftype == "help"
      end,
    },
    { title = "Neotest Output", ft = "neotest-output-panel", size = { height = 15 } },
  },
  left = {
    { ft = "codecompanion", title = "Code Companion", size = { width = 0.3 } }
  },
  right = {
    { ft = "neotest-summary", title = "Neotest Summary", size = { width = 0.2 } },
  },
}
