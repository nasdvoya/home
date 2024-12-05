local M = {}

function M.setup()
  -- Start live-server
  vim.api.nvim_create_user_command("StartLiveServer", function()
    local buffer_path = vim.fn.expand('%:p:h')
    vim.fn.jobstart("live-server --host=127.0.0.1 --port=8080 " .. buffer_path, {
      on_stdout = function(_, data)
        print(table.concat(data, "\n"))
      end,
      on_stderr = function(_, data)
        print("Error starting live-server: " .. table.concat(data, "\n"))
      end,
    })
  end, {})
  -- Stop live-server
  vim.api.nvim_create_user_command('StopLiveServer', function()
    vim.fn.jobstart('pkill live-server', {
      on_stderr = function(_, data)
        print("Error stopping live-server: " .. table.concat(data, "\n"))
      end,
    })
  end, {})
  local attach_to_buffer = function(output_bufnr, pattern, command)
    vim.api.nvim_create_autocmd("BufWritePost", {
      group = vim.api.nvim_create_augroup("RunAnything", { clear = true }),
      pattern = pattern,
      callback = function()
        local append_data = function(_, data)
          if data then
            vim.api.nvim_buf_set_lines(output_bufnr, -1, -1, false, data)
          end
        end

        vim.api.nvim_buf_set_lines(output_bufnr, 0, -1, false, { "!!!Output:" })
        vim.fn.jobstart(command, {
          stdout_buffered = true,
          on_stdout = append_data,
          on_stderr = append_data,
        })
      end,
    })
  end
  vim.api.nvim_create_user_command("Run", function()
    print "Run anything"
    local bufnr = vim.fn.input "Bufnr: "
    local pattern = vim.fn.input "Pattern: "
    local command = vim.split(vim.fn.input "Command: ", " ")
    attach_to_buffer(tonumber(bufnr), pattern, command)
  end, {})

  -- Timestamp
  vim.api.nvim_create_user_command("Time", function()
    local date = os.date("%d-%m-%Y %H:%M:%S")
    vim.api.nvim_put({ date }, "c", true, true)
  end, {})
end

return M
