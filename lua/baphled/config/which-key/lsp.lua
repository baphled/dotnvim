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
    { "<F2>",  "<cmd>lua vim.lsp.buf.rename()<cr>",   desc = "Rename" },
    { "[d",    "<cmd>vim.diagnostic.goto_prev()<cr>", desc = "Goto Previous Definition" },
    { "]d",    "<cmd>vim.diagnostic.goto_next()<cr>", desc = "Goto Next Definition" },
    { "<C-k>", "<cmd>lua vim.lsp.buf.hover()<cr>",    desc = "Hover" },
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
    { "ga",    "<cmd>lua vim.lsp.buf.code_action()<cr>",     desc = "Find Code Actions" },
    { "gD",    "<cmd>lua vim.lsp.buf.declaration()<cr>",     desc = "Find Declaration" },
    { "gf",    "<cmd>Telescope lsp_definitions<cr>",         desc = "Find Definition" },
    { "gi",    "<cmd>Trouble lsp_implementations<cr>",       desc = "List Implementation" },
    { "gl",    "<cmd>lua vim.diagnostic.open_float()<cr>",   desc = "Find Document Diagnostics" },
    { "go",    "<cmd>lua vim.lsp.buf.type_definition()<cr>", desc = "Find Document Diagnostics" },
    { "<M-l>", "<cmd>Telescope lsp_references<cr>",          desc = "Find Declaration", },
    { "<M-s>", "<cmd>lua vim.lsp.buf.signature_help()<cr>",  desc = "Find Document Symbols", },
    {
      "<C-l>",
      "<cmd>Trouble lsp toggle focus=false  win = { type = split, position=right, bo = { filetype = trouble_lsp }}<cr>",
      desc = "LSP Definitions / references / ... (Trouble)",
    },
    {
      "<C-s>",
      "<cmd>Trouble symbols toggle focus=false  win = { type = split, position=right, bo = { filetype = trouble_symbols }}<cr>",
      desc = "Symbols (Trouble)",
    },
  }
})

which_key.add({
  {
    "<M-l>",
    "<cmd>Telescope lsp_references<cr>",
    desc = "Find Declaration",
    mode = "i",
    nowait = false,
    remap = false
  },
  {
    "<M-s>",
    "<cmd>lua vim.lsp.buf.signature_help()<cr>",
    desc = "Find Document Symbols",
    mode = "i",
    nowait = false,
    remap = false
  },
})
