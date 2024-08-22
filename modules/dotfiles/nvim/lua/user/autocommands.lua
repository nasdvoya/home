-- Autocommands

-- Group for format on save
local format_on_save_group = vim.api.nvim_create_augroup("format_on_save", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  group = format_on_save_group,
  pattern = "*",
  desc = "Run LSP formatting on a file on save",
  callback = function()
    if vim.fn.exists(":Format") > 0 then
      vim.cmd.Format()
    end
  end,
})

-- Group for highlight yank
local highlight_yank_group = vim.api.nvim_create_augroup("highlight_yank", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  group = highlight_yank_group,
  pattern = "*",
  desc = "Highlight selection on yank",
  callback = function()
    vim.highlight.on_yank({ timeout = 200, visual = true })
  end,
})

-- Group for file type specific settings
local filetype_group = vim.api.nvim_create_augroup("filetype_settings", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = filetype_group,
  pattern = "oil",
  callback = function()
    vim.opt_local.colorcolumn = ""
  end,
})
