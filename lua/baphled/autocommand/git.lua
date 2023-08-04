local Baphled_Fugitive = vim.api.nvim_create_augroup("Baphled_Fugitive", {})
local autocmd = vim.api.nvim_create_autocmd

-- Enable spell check and word wrap for certain file types
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown", "txt" },
  desc = "Enable spell checking and text wrapping for certain filetypes",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Exit git diff buffer with ESC or q
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "git" },
  desc = "Exit git diff buffer with ESC",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "<Esc>", ":bd!<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "q", ":bd!<CR>", { noremap = true, silent = true })
  end,
})


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
