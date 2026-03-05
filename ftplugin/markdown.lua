-- Defer quarto activation until buffer is fully loaded
vim.defer_fn(function()
  local buf = vim.api.nvim_get_current_buf()
  if vim.api.nvim_buf_is_loaded(buf) then
    require("quarto").activate()
  end
end, 0)
