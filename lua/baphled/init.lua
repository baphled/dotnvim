require("baphled.set")
require("baphled.motions")
require("baphled.autocommand")

require("baphled.plugins")

vim.g.mapleader = " "

local augroup = vim.api.nvim_create_augroup
local BaphledGroup = augroup('baphled', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
    require("plenary.reload").reload_module(name)
end

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({"BufWritePre"}, {
    group = BaphledGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})
