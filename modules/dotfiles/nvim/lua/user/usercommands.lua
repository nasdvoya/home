local M = {}

function M.setup()
  vim.api.nvim_create_user_command("StartLiveServer", function()
    vim.fn.jobstart("live-server --host=127.0.0.1 --port=8080 " .. vim.fn.getcwd(), {
      on_stdout = function(_, data)
        print(table.concat(data, "\n"))
      end,
      on_stderr = function(_, data)
        print("Error: " .. table.concat(data, "\n"))
      end,
    })
  end, {})

  vim.api.nvim_create_user_command('StopLiveServer', function()
    vim.fn.jobstart('pkill live-server', {
      on_stderr = function(_, data)
        print("Error stopping live-server: " .. table.concat(data, "\n"))
      end,
    })
  end, {})
end

return M
