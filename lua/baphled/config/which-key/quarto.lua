local which_key = require("which-key")
local runner = require("quarto.runner")

which_key.add({
  {
    "<leader>RA",
    function()
      runner.run_all(true)
    end,
    desc = "run all cells of all languages",
    nowait = false,
    remap = false
  },
  {
    "<leader>ra",
    runner.run_all,
    desc = "run all cells",
    nowait = false,
    remap = false
  },
  {
    "<leader>rc",
    runner.run_cell,
    desc = "run cell",
    nowait = false,
    remap = false
  },
  {
    "<leader>rl",
    runner.run_line,
    desc = "run line",
    nowait = false,
    remap = false
  },
  {
    "<leader>rv",
    runner.run_range,
    desc = "run visual range",
    mode = "v",
    nowait = false,
    remap = false
  },
})
