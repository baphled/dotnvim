vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- search settings
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.smartcase = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"
vim.opt.textwidth = 80

vim.opt.title = true
vim.opt.titlestring = "%t - nvim"

vim.opt.showmatch = true
vim.opt.showmode = true

-- fold settings
vim.opt.foldcolumn = "0"
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 9

-- Jump to last edit location when opening files
vim.cmd [[ autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif ]]

-- Spell checking
vim.opt.spelllang = "en_gb"
vim.opt.spellfile = os.getenv("HOME") .. "/.vim/spell/en.utf-8.add"
vim.opt.spell = true

vim.opt.numberwidth = 4

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
