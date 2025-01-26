require("config.options")
require("config.lazy")
require("config.keymaps").normal()
require("config.keymaps").visual()
require("config.keymaps").terminal()
require("config.keymaps").diagnostic()

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highligt when yanking text",
  group = vim.api.nvim_create_augroup("kickstart-hightlight-yank", { clear = true }),
  callback = function() vim.highlight.on_yank() end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.cs",
  callback = function() vim.lsp.codelens.refresh({ bufnr = 0 }) end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("DefaultLspAttach", { clear = true }),
  callback = function(event)
    local buf = event.buf
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if not client then return end

    -- Key mappings
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition", buffer = buf })
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation", buffer = buf })
    vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, { desc = "Signature help", buffer = buf })
    vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename symbol", buffer = buf })
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions", buffer = buf })
  end,
})
