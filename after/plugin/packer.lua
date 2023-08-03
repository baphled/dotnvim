local startup_theme = "startup.evil"

if string.find(vim.fn.getcwd(), "n-vyro") then
  vim.print("n-vyro")
  startup_theme = "baphled.startup.themes.nvyro"
else
  vim.print("boodah")
  startup_theme = "baphled.startup.themes.boodah"
end
require("startup").setup(require(startup_theme))

vim.keymap.set("n", "<C-w>i", "<cmd>PackerSync<CR>", { noremap = true })
