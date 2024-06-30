vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- disable netrw at the very start of your init.lua (For NvimTree plugin)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.o.conceallevel = 2
-- Enable incremental searching
vim.opt.incsearch = true
vim.opt.hlsearch = true
-- Enable mouse mode
vim.opt.mouse = 'a'
-- Enable access to System Clipboard
vim.opt.clipboard = "unnamed,unnamedplus"
-- Enable persistent undo history
vim.opt.undofile = true
-- Enable ignorecase + smartcase for better searching
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- Enable the sign column to prevent the screen from jumping
vim.opt.signcolumn = 'yes'
-- Decrease updatetime to 200ms
vim.opt.updatetime = 250 -- check
vim.opt.timeoutlen = 300 -- check
-- Set completeopt to have a better completion experience
vim.opt.completeopt = 'menuone,noselect'
-- Enable 24-bit color
vim.opt.termguicolors = true
-- Tabs to 4 spaces
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
-- Auto indenting
vim.opt.smartindent = true -- test
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
-- Enable smart indenting (see https://stackoverflow.com/questions/1204149/smart-wrap-in-vim)
vim.opt.breakindent = true -- test
-- Always keep 8 lines above/below cursor unless at start/end of file
vim.opt.scrolloff = 8      -- test
-- Enable cursor line highlight
vim.opt.cursorline = true

-- Window-local options
vim.wo.number = true
vim.wo.relativenumber = true
