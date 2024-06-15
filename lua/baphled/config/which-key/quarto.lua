local which_key = require("which-key")

local runner = require("quarto.runner")

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

local normal_quatro_mappings = {
  ["<leader>"] = {
    ["rc"] = {
      runner.run_cell,
      "run cell"
    },
    ["ra"] = {
      runner.run_all,
      "run all cells"
    },
    ["rl"] = {
      runner.run_line,
      "run line"
    },
    ["RA"] = {
      function()
        runner.run_all(true)
      end,
      "run all cells of all languages"
    },
  }
}

local visual_quatro_mappings = {
  ["<leader>"] = {
    ["rv"] = {
      runner.run_range,
      "run visual range"
    },
  }
}

which_key.register(normal_quatro_mappings, normal_opts)
which_key.register(visual_quatro_mappings, visual_opts)
