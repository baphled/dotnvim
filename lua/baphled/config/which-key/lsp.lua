local which_key = require("which-key")

which_key.add({
  {
    "g",
    group = "LSP",
  },
  {
    "<C-h>",
    "<cmd>lua vim.lsp.buf.signature_help()<cr>",
    desc = "Signature Help",
    mode = "i",
    nowait = false,
    remap = false
  },
  {
    mode = "n",
    { "<F2>",  "<cmd>lua vim.lsp.buf.rename()<cr>",      desc = "Rename" },
    { "<F3>",  "<cmd>lua vim.lsp.buf.definition()<cr>",  desc = "Find Definition" },
    { "<F4>",  "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Find Code Actions" },
    { "<C-k>", "<cmd>lua vim.lsp.buf.hover()<cr>",       desc = "Hover" },
    { "[d",    "<cmd>vim.diagnostic.goto_prev()<cr>",    desc = "Goto Previous Definition" },
    { "]d",    "<cmd>vim.diagnostic.goto_next()<cr>",    desc = "Goto Next Definition" },
    { "K",     "<cmd>lua vim.lsp.buf.hover()<cr>",       desc = "Hover" },
    {
      "<leader>f",
      function()
        vim.lsp.buf.format({
          async = true,
          save_after_format = true,
        })
      end,
      desc = "Format"
    },
    { "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>",     desc = "Find Declaration" },
    { "gf", "<cmd>Telescope lsp_definitions<cr>",         desc = "Find Definition" },
    { "gi", "<cmd>Trouble lsp_implementations<cr>",       desc = "List Implementation" },
    { "gl", "<cmd>lua vim.diagnostic.open_float()<cr>",   desc = "Find Document Diagnostics" },
    { "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", desc = "Find Document Diagnostics" },
    { "gr", "<cmd>Telescope lsp_references<cr>",          desc = "Find Declaration" },
    { "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>",  desc = "Find Document Symbols" },
  }
})
