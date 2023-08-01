require("nvim-tree").setup({
  sort_by = "case_sensitive",
  disable_netrw = true,
  hijack_cursor = true,
  update_cwd = true,
  diagnostics = {
    enable = true,
  },
  actions = {
    open_file = {
      quit_on_open = true,
    }
  },
  view = {
    float = {
      enable = true,
      open_win_config = {
        border = "rounded",
        width = 50,
        height = 30,
        row = 10,
        col = 58,
      },
    }
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
})

vim.keymap.set("n", "<leader>nt", ":NvimTreeOpen<CR>")
vim.keymap.set("n", "<leader>no", ":NvimTreeClose<CR>")
vim.keymap.set("n", "<leader>np", ":NvimTreeFindFile<CR>")
