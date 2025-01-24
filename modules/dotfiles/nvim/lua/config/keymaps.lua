local M = {}

M.normal = function()
  vim.keymap.set("n", "<space>", "<nop>", { desc = "Disable space in normal" })
  vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save current buffer" })
  vim.keymap.set("n", "<leader>wa", "<cmd>wa<cr>", { desc = "Save all buffers" })
  vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit current buffer" })
  vim.keymap.set("n", "L", "$", { desc = "Mode to end of line" })
  vim.keymap.set("n", "H", "^", { desc = "Move to begining of line" })
  vim.keymap.set("n", "<esc>", "<cmd>noh<cr>", { desc = "Clear search highlights" })
  vim.keymap.set("n", "S", function()
    local cmd = ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>"
    local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
    vim.api.nvim_feedkeys(keys, "n", false)
  end, { desc = "Find and replace" })
  vim.keymap.set("n", "<leader>ch", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  end, { desc = "Toggle Inlay Hints" })
end

M.diagnostic = function()
  vim.keymap.set("n", "<leader>dy", function()
    vim.diagnostic.open_float()
    vim.diagnostic.open_float()
    local win_id = vim.fn.win_getid()
    vim.cmd("normal! j")
    vim.cmd("normal! VG")
    vim.cmd("normal! y")
    vim.api.nvim_win_close(win_id, true)
  end, { desc = "Yank error", })
end

M.terminal = function()
  vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], { desc = "Terminal: Exit to normal mode" })
  vim.keymap.set("t", "<space>", "<space>", { desc = "Terminal: Reenable default space function" })
end

M.visual = function()
  vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down and reselect" })
  vim.keymap.set("v", "<A-k>", ":m '>-2<CR>gv=gv", { desc = "Move selected lines up and reselect" })
  vim.keymap.set("v", "L", "$<left>", { desc = "Mode to end of line" })
  vim.keymap.set("v", "H", "^", { desc = "Move to begining of line" })
  vim.keymap.set("v", "<space>", "<nop>", { desc = "Disable space in visual" })
end

return M
