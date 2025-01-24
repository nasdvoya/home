vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.conceallevel = 0 -- Disable conceal

vim.wo.number = true
vim.wo.relativenumber = false

vim.opt.shiftwidth = 4
vim.opt.clipboard = "unnamed,unnamedplus" -- Enable access to System Clipboard
vim.opt.incsearch = true                  -- Search highlight
vim.opt.hlsearch = true                   -- Highlight search results
vim.opt.mouse = "a"                       -- Enable mouse mode in all modes
vim.opt.undofile = true                   -- Enable persistent undo history
vim.opt.ignorecase = true                 -- Enable ignorecase in search patterns
vim.opt.smartcase = true                  -- Dont ignore case when pattern has uppercase
vim.opt.signcolumn = "yes"                -- Always show signcolumns (git diff for example)
vim.opt.updatetime = 250                  -- Events like diagnostic update, swap, cursor hold
vim.opt.timeoutlen = 300                  -- Keybind more responsive
vim.opt.completeopt = "menuone,noselect"  -- Set completeopt to have a better completion experience
vim.opt.termguicolors = true              -- Enable 24-bit color
vim.opt.tabstop = 4                       -- Tabs to 4 spaces
vim.opt.softtabstop = 4
vim.opt.smartindent = true                -- Auto indenting
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.breakindent = true
vim.opt.scrolloff = 999   -- Center the cursor
vim.opt.cursorline = true -- Enable cursor line highlight
