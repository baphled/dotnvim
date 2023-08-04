local Baphled_Fugitive = vim.api.nvim_create_augroup("Baphled_Fugitive", {})
local autocmd = vim.api.nvim_create_autocmd

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
