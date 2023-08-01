require("other-nvim").setup({
  mappings = {
    "golang",
    "javascript",
    "rails",
    -- ruby
    {
      pattern = "lib/(.*).rb$",
      target = "spec/%1_spec.rb",
      context = "spec",
    },
    {
      pattern = "spec/(.*)_spec.rb$",
      target = "lib/%1.rb",
      context = "src",
    },
    -- javascript
    {
      pattern = "/src/(.*).js$",
      target = "/tests/unit/%1.spec.js",
      context = "spec",
    },
    {
      pattern = "/tests/unit/(.*).spec.js$",
      target = "/src/1.js",
      context = "src",
    },
    -- VueJS
    {
      pattern = "/src/(.*).vue$",
      target = "/tests/unit/%1.spec.js",
      context = "spec",
    },
    {
      pattern = "/tests/unit/(.*).spec.js$",
      target = "/src/%1.vue",
      context = "src",
    },
    -- Storybook
    {
      pattern = "/src/(.*).vue$",
      target = "/src/%1.stories.js",
      context = "story",
    },
  }
})

-- Replicate the default mappings
-- :AV Alternative Vertical
-- :AS Alternative Split
-- :AT Alternative Tab
-- :A Alternative

-- :AV command
vim.api.nvim_create_user_command("AV", "OtherVSplit", {})

-- :AS command
vim.api.nvim_create_user_command("AS", "OtherSplit", {})

-- :A command
vim.api.nvim_create_user_command("A", "Other", {})
