local which_key = require("which-key")
local flash = require("flash")

which_key.add({
  mode = { "n", "x", "o" },
  group = "Flash",
  {
    "s",
    function()
      flash.jump()
    end,
    desc = "Flash Search",
    nowait = false,
    remap = false,
  },
})
which_key.add({
  mode = "o",
  group = "Flash",
  {
    "r",
    function()
      flash.remote()
    end,
    desc = "Flash Remote Search",
    nowait = false,
    remap = false
  },
});

which_key.add({
  mode = { "o", "x" },
  group = "Flash",
  {
    "R",
    function()
      flash.treesitter.search()
    end,
    desc = "Flash Treesitter Search",
    nowait = false,
    remap = false
  },
});

which_key.add({
  mode = "c",
  group = "Flash",
  {
    "<c-s>",
    function()
      flash.toggle()
    end,
    desc = "Toggle Flash",
    nowait = false,
    remap = false
  },
});
