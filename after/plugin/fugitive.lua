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

vim.keymap.set("n", "<leader>gdc", function()
  vim.cmd.Git('diff --cached')
  -- trigger new tab
  vim.cmd('tabnew %')
end)

-- When call :Gdiffsplit, we want to open the diff in a new tab

-- Sign a commit
--
-- By we always sign our commits
vim.keymap.set("n", "<leader>gc", function()
  vim.cmd.Git('commit -s')
end)

autocmd("BufWinEnter", {
  group = Baphled_Fugitive,
  pattern = "*",
  callback = function()
    if vim.bo.ft ~= "fugitive" then
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

vim.g.Editor_exclude_patterns = { 'fugitive://.*' }
