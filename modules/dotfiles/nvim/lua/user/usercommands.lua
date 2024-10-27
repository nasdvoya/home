local M = {}

function M.setup()
  vim.api.nvim_create_user_command("StartLiveServer", function()
    vim.fn.jobstart("live-server" .. vim.fn.getcwd())
  end, {})

  vim.api.nvim_create_user_command('StopLiveServer', function()
    vim.fn.jobstart('pkill live-server')
  end, {})
end

return M
