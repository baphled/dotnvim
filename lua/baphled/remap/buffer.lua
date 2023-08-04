-- Buffer navigation
--

-- Take current buffer, open it in a new tab and close the current buffer
vim.keymap.set("n", "<leader>tb", function()
  -- Create a new tab with current buffer
  vim.cmd("tabedit %")

  -- Go to the previous tab
  vim.cmd("tabprevious")

  -- Delete the current buffer
  vim.cmd("q")

  -- Go to the new tab
  vim.cmd("tabnext")
end)
