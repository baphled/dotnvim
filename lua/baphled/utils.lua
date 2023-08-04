_M = {}

-- Move the current window to a new tab
-- and close the current buffer
--
function move_window_in_tab()
  -- Create a new tab with current buffer
  vim.cmd("tabedit %")

  -- Go to the previous tab
  vim.cmd("tabprevious")

  -- Delete the current buffer
  vim.cmd("q")

  -- Go to the new tab
  vim.cmd("tabnext")
end

_M.move_window_in_tab = move_window_in_tab

return _M
