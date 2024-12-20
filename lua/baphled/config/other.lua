require("other-nvim").setup({
  mappings = {
    "golang",
    "javascript",
    "rails",
    -- ruby
    {
      pattern = "spec/support/matchers/(.*).rb$",
      target = "spec/matchers/%1_spec.rb",
      context = "matchers",
    },
    {
      pattern = "spec/matchers/(.*)_spec.rb$",
      target = "spec/support/matchers/%1.rb",
      context = "matchers",
    },
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
    {
      pattern = "Gemfile$",
      target = "Gemfile.lock",
      context = "lock",
    },
    {
      pattern = "Gemfile.lock$",
      target = "Gemfile",
      context = "src",
    },
    -- javascript
    {
      pattern = "/src/(.*).js$",
      target = "/tests/%1.spec.js",
      context = "spec",
    },
    {
      pattern = "/tests/(.*).spec.js$",
      target = "/src/%1.js",
      context = "src",
    },
    {
      pattern = "/src/(.*).js$",
      target = "/tests/unit/%1.spec.js",
      context = "spec",
    },
    {
      pattern = "/tests/unit/(.*).spec.js$",
      target = "/src/%1.js",
      context = "src",
    },
    {
      pattern = "/src/(.*).js$",
      target = "/test/%1.spec.js",
      context = "spec",
    },
    {
      pattern = "/test/(.*).spec.js$",
      target = "/src/%1.js",
      context = "src",
    },
    {
      pattern = "package.json$",
      target = "package-lock.json",
      context = "lock",
    },
    {
      pattern = "package-lock.json$",
      target = "package.json",
      context = "src",
    },
    -- TypeScript
    {
      pattern = "/src/(.*)/(.*).(ts)$",
      target = "/src/%1/__tests__/%2.spec.js",
      context = "spec",
    },
    {
      pattern = "/src/(.*).(ts)$",
      target = "/src/%1.test.ts",
      context = "spec",
    },
    {
      pattern = "/src/(.*).(ts)$",
      target = "/src/%1.test.js",
      context = "spec",
    },
    {
      pattern = "/src/(.*)/(.*).(ts)$",
      target = "/src/%1/__tests__/%2.test.js",
      context = "spec",
    },
    {
      pattern = "/src/(.*)/__tests__/(.*).spec.js$",
      target = "/src/%1/%2.ts",
      context = "src",
    },
    {
      pattern = "/src/(.*)/__tests__/(.*).test.js$",
      target = "/src/%1/%2.ts",
      context = "src",
    },
    {
      pattern = "/src/(.*).test.(ts)$",
      target = "/src/%1.ts",
      context = "spec",
    },
    {
      pattern = "/src/(.*).test.(js)$",
      target = "/src/%1.ts",
      context = "spec",
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
    {
      pattern = "/src/(.*).stories.js",
      target = "/src/%1.vue",
      context = "src",
    },
    {
      pattern = "/src/(.*).stories.js$",
      target = "/tests/unit/%1.spec.js",
      context = "spec",
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
