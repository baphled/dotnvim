local which_key = require("which-key")

local insert_opts = {
  mode = "i",
  prefix = "",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

local normal_opts = {
  mode = "n",
  prefix = "",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

local lsp_insert_mappings = {
  ["<C-h>"] = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature Help" },
}

which_key.register(lsp_insert_mappings, insert_opts)

local lsp_normal_mappings = {
  ["<F2>"] = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
  ["<F3>"] = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Find Definition" },
  ["<F4>"] = {
    name = "Actions",
    r = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Find Code Actions" },
  },
  ["<C-k>"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover" },
  ['[d'] = { "<cmd>vim.diagnostic.goto_prev()<cr>", "Goto Previous Definition" },
  [']d'] = { "<cmd>vim.diagnostic.goto_next()<cr>", "Goto Next Definition" },
  ['K'] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover" },
  ['<leader>'] = {
    f = {
      function()
        vim.lsp.buf.format({
          async = true,
          save_after_format = true,
        })
      end,
      "Format"
    },
  },
  g = {
    f = {
      "<cmd>Telescope lsp_definitions<cr>", "Find Definition"
    },
    D = {
      "<cmd>lua vim.lsp.buf.declaration()<cr>", "Find Declaration"
    },
    o = {
      "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Find Document Diagnostics"
    },
    i = {
      "<cmd>Trouble lsp_implementations<cr>", "List Implementation"
    },
    l = {
      "<cmd>lua vim.diagnostic.open_float()<cr>", "Find Document Diagnostics"
    },
    r = {
      "<cmd>Telescope lsp_references<cr>", "Find Declaration"
    },
    s = {
      "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Find Document Symbols"
    },
  },
}

which_key.register(lsp_normal_mappings, normal_opts)
