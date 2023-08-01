require("coverage").setup({
  auto_reload = true,
  signs = {
    -- use your own highlight groups or text markers
    covered = { hl = "CoverageCovered", text = "▎" },
    uncovered = { hl = "CoverageUncovered", text = "▎" },
  },
})

vim.keymap.set("n", "<Leader>cs", "<cmd>CoverageSummary<cr>", { noremap = false })

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local CoverageGroup = augroup('Coverage', {})

-- Split the mime type into the main type and the subtype
-- e.g. text/x-lua
-- main type: text
-- subtype: x-lua
--
-- Remove the x- from the subtype
-- e.g. x-lua -> lua
local split_mime_type = function(mime_type)
  local _main_type, sub_type = string.match(mime_type, "(%a+)/(.*)")
  local language = string.gsub(sub_type, "^x%-", "")

  return language
end

-- Check if the current file is supported
local function is_supported_filetype()
  local file_path = vim.fn.expand('%:p')

  if vim.fn.filereadable(file_path) == 0 then
    return nil
  end

  local mime_type = vim.fn.system('file --mime-type -b ' .. vim.fn.shellescape(file_path))
  local language = split_mime_type(mime_type)

  return language
end

-- Load coverage if the current file is supported
local function load_coverage_if_supported()
  local language = is_supported_filetype()
  local coverage = require("coverage")
  if language == nil then
    return
  end

  local success, result = pcall(coverage.load, true)
  if success then
    coverage.show()
  end
end

-- Load coverage when opening a file
-- if code coverage files are found in the current directory
-- load them and show the coverage
--
-- This is useful when you have a test runner that generates
-- coverage files in the current directory
autocmd('BufRead, BufWritePost', {
  group = CoverageGroup,
  pattern = "*",
  callback = load_coverage_if_supported,
})
