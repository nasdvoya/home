return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'williamboman/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',
      'nvim-neotest/nvim-nio',
    },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'

      -- Function to get project name from .csproj file
      local function get_project_name()
        local cwd = vim.fn.getcwd()
        local project_name = nil

        -- Iterate over all files in the current directory
        for _, file in ipairs(vim.fn.readdir(cwd)) do
          if file:match("%.csproj$") then
            project_name = file:gsub("%.csproj$", "")
            break
          end
        end

        return project_name
      end

      -- Function to find the DLL file path
      local function find_dll_path()
        local project_name = get_project_name()
        if not project_name then
          return nil
        end

        local cwd = vim.fn.getcwd()
        local dll_path = nil

        -- Check for all directories under bin/Debug
        local debug_dirs = vim.fn.glob(cwd .. '/bin/Debug/*', 1, 1)
        for _, dir in ipairs(debug_dirs) do
          local potential_path = dir .. '/' .. project_name .. '.dll'
          if vim.loop.fs_stat(potential_path) then
            dll_path = potential_path
            break
          end
        end

        return dll_path
      end

      dap.adapters.coreclr = {
        type = 'executable',
        command = 'netcoredbg', -- Use the command available in the environment
        args = { '--interpreter=vscode' }
      }

      dap.configurations.cs = {
        {
          type = "coreclr",
          name = "launch - netcoredbg",
          request = "launch",
          program = function()
            local dll_path = find_dll_path()
            if dll_path then
              return dll_path
            else
              return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
            end
          end,
        },
      }

      require('mason-nvim-dap').setup {
        automatic_setup = true,
        handlers = {},
        ensure_installed = {
        },
      }
      -- Setup Dap UI
      dapui.setup {
        icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
        controls = {
          icons = {
            pause = '⏸',
            play = '▶',
            step_into = '⏎',
            step_over = '⏭',
            step_out = '⏮',
            step_back = 'b',
            run_last = '▶▶',
            terminate = '⏹',
            disconnect = '⏏',
          },
        },
      }
      dap.listeners.after.event_initialized['dapui_config'] = dapui.open
      dap.listeners.before.event_terminated['dapui_config'] = dapui.close
      dap.listeners.before.event_exited['dapui_config'] = dapui.close
    end,
  }
}
