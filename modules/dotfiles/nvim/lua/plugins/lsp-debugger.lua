return {
  {
    -- Unison language
    "unisonweb/unison",
    branch = "trunk",
    config = function(plugin)
      vim.opt.rtp:append(plugin.dir .. "/editor-support/vim")
      require("lazy.core.loader").packadd(plugin.dir .. "/editor-support/vim")
    end,
    init = function(plugin)
      require("lazy.core.loader").ftdetect(plugin.dir .. "/editor-support/vim")
    end,
  },
  {
    -- Better lsp tools for omnisharp
    'Hoffs/omnisharp-extended-lsp.nvim'
  },
  {
    -- Better lsp diagnostics
    'dgagn/diagflow.nvim',
    opts = {}
  },
  {
    -- Debugger
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

      require('mason-nvim-dap').setup {
        automatic_setup = true,
        handlers = {},
        ensure_installed = {
          -- Update this to ensure that you have the debuggers for the langs you want
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
      -- Install golang specific config
      --require('dap-go').setup()
    end,
  },
  {
    -- LSP
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim',          config = true },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'j-hui/fidget.nvim',                tag = 'legacy', opts = {} },
      { 'folke/neodev.nvim' }
    },
    config = function()
      local keymaps = require("user.keymaps")
      local on_attach = function(_, buffer_number)
        if _.name == "omnisharp" then
          keymaps.omnisharp(buffer_number)
        else
          keymaps.default_lsp(buffer_number)
        end
        vim.api.nvim_buf_create_user_command(buffer_number, 'Format', function(_)
          vim.lsp.buf.format()
        end, { desc = 'Format current buffer with LSP' })
      end

      local servers = {
      }

      -- Setup neovim lua configuration
      require('neodev').setup()

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      -- Ensure the servers above are installed
      local mason_lspconfig = require 'mason-lspconfig'

      mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(servers),
      }

      mason_lspconfig.setup_handlers {
        function(server_name)
          require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
          }
        end
      }
    end,
  }
}
