-- Set Python3 host program to use pyenv neovim virtualenv
local pyenv_root = vim.fn.expand('~/.pyenv')
local neovim_venv = pyenv_root .. '/versions/neovim'

if vim.fn.isdirectory(neovim_venv) == 1 then
  vim.g.python3_host_prog = neovim_venv .. '/bin/python'
end
