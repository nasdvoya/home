require("config.options")
require("config.lazy")
require("config.keymaps").normal()
require("config.keymaps").visual()
require("config.keymaps").terminal()
require("config.keymaps").diagnostic()

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highligt when yanking text',
  group = vim.api.nvim_create_augroup('kickstart-hightlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
