-- change the configuration when editing a python file
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.py",
  callback = function(e)
    if string.match(e.file, ".otter.") then
      return
    end
    -- Only check molten status if the plugin is available
    local ok, molten_status = pcall(require, "molten.status")
    local is_molten = false
    if ok then
      local status_ok, status = pcall(molten_status.initialized)
      is_molten = status_ok and status == "Molten"
    end
    
    if is_molten then
      vim.fn.MoltenUpdateOption("virt_lines_off_by_1", false)
      vim.fn.MoltenUpdateOption("virt_text_output", false)
    else
      vim.g.molten_virt_lines_off_by_1 = false
      vim.g.molten_virt_text_output = false
    end
  end,
})

-- Undo those config changes when we go back to a markdown or quarto file
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.qmd", "*.md", "*.ipynb" },
  callback = function(e)
    if string.match(e.file, ".otter.") then
      return
    end
    -- Only check molten status if the plugin is available
    local ok, molten_status = pcall(require, "molten.status")
    local is_molten = false
    if ok then
      local status_ok, status = pcall(molten_status.initialized)
      is_molten = status_ok and status == "Molten"
    end
    
    if is_molten then
      vim.fn.MoltenUpdateOption("virt_lines_off_by_1", true)
      vim.fn.MoltenUpdateOption("virt_text_output", true)
    else
      vim.g.molten_virt_lines_off_by_1 = true
      vim.g.molten_virt_text_output = true
    end
  end,
})
