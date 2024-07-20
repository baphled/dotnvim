local which_key = require("which-key")

local normal_opts = {
  mode = "n",
  prefix = "",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

local visual_opts = {
  mode = "v",
  prefix = "",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

local normal_molten_mappings = {
  ["<leader>"] = {
    ["e"] = {
      "<cmd>MoltenEvaluateOperator<cr>",
      "evaluate operator"
    },
    ["ms"] = {
      "<cmd>noautocmd MoltenEnterOutput<cr>",
      "open output window"
    },
    ["mc"] = {
      "<cmd>MoltenReevaluateCell<CR>",
      "evaluate cell"
    },
    ["ml"] = {
      "<cmd>MoltenEvaluateLine<CR>",
      "evaluate line"
    },
    ["mh"] = {
      "<cmd>MoltenHideOutput<cr>",
      "close output window"
    },
    ["md"] = {
      "<cmd>MoltenDelete<cr>",
      "delete Molten cell"
    },
    ["mx"] = {
      "<cmd>MoltenOpenInBrowser<cr>",
      "open output in browser"
    },
  }
}

local visual_molten_mappings = {
  ["<leader>"] = {
    ["mr"] = {
      ":<C-u>MoltenEvaluateVisual<CR>gv",
      "execute visual selection"
    },
  }
}

which_key.register(normal_molten_mappings, normal_opts)
which_key.register(visual_molten_mappings, visual_opts)
