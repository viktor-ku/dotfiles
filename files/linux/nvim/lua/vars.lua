vim.g.t_co = 256

-- Updated the packpath
local packer_path = vim.fn.stdpath('config') .. '/site'
vim.o.packpath = vim.o.packpath .. ',' .. packer_path

vim.opt.completeopt={"menu", "menuone", "noselect"}
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

vim.o.termguicolors = true

vim.g.mapleader = " "

vim.o.number = true

vim.o.swapfile = false

vim.o.updatetime = 300
vim.o.incsearch = false
vim.o.hlsearch = false
vim.wo.signcolumn = 'yes'
