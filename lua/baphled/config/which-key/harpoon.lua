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

local normal_opts = {
  mode = "n",
  prefix = "",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

local harpoon_mappings = {
  ["<leader>"] = {
    h = {
      name = "Harpoon",
      a = {
        function()
          harpoon:list():append()
        end,
        "Append Current File to Harpoon"
      },
      l = {
        function()
          toggle_telescope("Harpoon", harpoon:list())
        end,
        "Open Harpoon Window"
      },
      q = {
        function()
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        "Open Harpoon Quick Menu"
      },
      ["1"] = {
        function()
          harpoon:list():select(1)
        end,
        "Go to Harpoon Item 1"
      },
      ["2"] = {
        function()
          harpoon:list():select(2)
        end,
        "Go to Harpoon Item 2"
      },
      ["3"] = {
        function()
          harpoon:list():select(3)
        end,
        "Go to Harpoon Item 3"
      },
      ["4"] = {
        function()
          harpoon:list():select(4)
        end,
        "Go to Harpoon Item 4"
      },
      n = {
        function()
          harpoon:list():prev()
        end,
        "Go to Previous Harpoon Item"
      },
      p = {
        function()
          harpoon:list():next()
        end,
        "Go to Next Harpoon Item"
      }
    },
  },
}

which_key.register(harpoon_mappings, normal_opts)
