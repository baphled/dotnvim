local Baphled_Fugitive = vim.api.nvim_create_augroup("Baphled_Fugitive", {})
local autocmd = vim.api.nvim_create_autocmd

vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

vim.keymap.set("n", "<leader>gcf", function()
  vim.cmd.Git('checkout -- %')
end)

-- Git blame
vim.keymap.set("n", "<leader>gb", function()
  vim.cmd.Git('blame')
end)

-- When calling :Gdiffsplit, we want to open the diff in a new tab
--
vim.keymap.set("n", "<leader>gdc", function()
  vim.cmd.Git('diff --cached')
  -- trigger new tab
  vim.cmd('tabnew %')
end)

-- Sign a commit
--
-- By we always sign our commits
vim.keymap.set("n", "<leader>gc", function()
  vim.cmd.Git('commit -s')
end)

--Amend a commit
vim.keymap.set("n", "<leader>ga", function()
  vim.cmd.Git('commit --amend')
end)

-- Closing a git buffer should be easy
--
-- Close fugitive buffers with 'q'
--
autocmd("BufWinEnter", {
  group = Baphled_Fugitive,
  pattern = "*",
  callback = function()
    if vim.bo.ft ~= "fugitive" and vim.bo.ft ~= "fugitiveblame" then
      return
    end

    local bufnr = vim.api.nvim_get_current_buf()
    local opts = { buffer = bufnr, remap = false }

    -- Close git buffer
    vim.keymap.set("n", "q", function()
      vim.cmd("bd!")
    end, opts)
  end,
})
