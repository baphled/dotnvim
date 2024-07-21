local which_key = require("which-key")
local harpoon = require("harpoon")

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(title, harpoon_files)
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end

  require("telescope.pickers").new({}, {
    prompt_title = title,
    finder = require("telescope.finders").new_table({
      results = file_paths,
    }),
    previewer = conf.file_previewer({}),
    sorter = conf.generic_sorter({}),
  }):find()
end

which_key.add({
  {
    "<leader>h",
    group = "Harpoon",
    nowait = false,
    remap = false
  },
  {
    "<leader>h1",
    function()
      harpoon:list():select(1)
    end,
    desc = "Go to Harpoon Item 1",
    nowait = false,
    remap = false
  },
  {
    "<leader>h2",
    function()
      harpoon:list():select(2)
    end,
    desc = "Go to Harpoon Item 2",
    nowait = false,
    remap = false
  },
  {
    "<leader>h3",
    function()
      harpoon:list():select(3)
    end,
    desc = "Go to Harpoon Item 3",
    nowait = false,
    remap = false
  },
  {
    "<leader>h4",
    function()
      harpoon:list():select(4)
    end,
    desc = "Go to Harpoon Item 4",
    nowait = false,
    remap = false
  },
  {
    "<leader>ha",
    function()
      harpoon:list():append()
    end,
    desc = "Append Current File to Harpoon",
    nowait = false,
    remap = false
  },
  {
    "<leader>hl",
    function()
      toggle_telescope("Harpoon", harpoon:list())
    end,
    desc = "Open Harpoon Window",
    nowait = false,
    remap = false
  },
  {
    "<leader>hn",
    function()
      harpoon:list():prev()
    end,
    desc = "Go to Previous Harpoon Item",
    nowait = false,
    remap = false
  },
  {
    "<leader>hp",
    function()
      harpoon:list():next()
    end,
    desc = "Go to Next Harpoon Item",
    nowait = false,
    remap = false
  },
  {
    "<leader>hq",
    function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end,
    desc = "Open Harpoon Quick Menu",
    nowait = false,
    remap = false
  },
})
