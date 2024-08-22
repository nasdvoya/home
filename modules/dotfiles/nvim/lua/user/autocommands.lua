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

-- Group for LSP documentation in side buffer
local lsp_doc_group = vim.api.nvim_create_augroup("lsp_doc_in_side_buffer", { clear = true })
vim.api.nvim_create_autocmd("CursorHold", {
  group = lsp_doc_group,
  pattern = "*",
  desc = "Open documentation in a side buffer on cursor hold",
  callback = function()
    -- Function to open documentation in a side buffer
    local function open_doc_in_side_buffer()
      local bufnr = vim.api.nvim_get_current_buf()

      -- Use `vim.lsp.buf.hover` to get the documentation
      vim.lsp.buf.hover()

      -- Open a vertical split for the documentation
      vim.cmd('vsplit')

      -- Move the documentation to the new split
      vim.api.nvim_command('wincmd L')

      -- Set the buffer for the vertical split to the current buffer
      vim.api.nvim_set_current_buf(bufnr)
    end

    open_doc_in_side_buffer()
  end,
})
