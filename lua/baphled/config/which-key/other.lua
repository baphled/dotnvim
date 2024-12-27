local which_key = require("which-key")

which_key.add({
  {
    "<M-a>",
    group = "Other",
  },
  {
    "<M-a>a",
    function()
      vim.cmd("Other")
    end,
    desc = "Alternative",
  },
  {
    "<M-a>h",
    function()
      vim.cmd("OtherHSplit")
    end,
    desc = "Alternative Horizontal Split",
  },
  {
    "<M-a>v",
    function()
      vim.cmd("OtherVSplit")
    end,
    desc = "Alternative Vertical Split",
  },
  {
    "<M-a>s",
    function()
      vim.cmd("OtherSplit")
    end,
    desc = "Alternative Split",
  },
  {
    "<M-a>t",
    function()
      vim.cmd("OtherTab")
    end,
    desc = "Alternative Tab",
  },
})
