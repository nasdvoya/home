return {
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
        rust_analyzer = {},
        nil_ls = {},
        omnisharp = {
          enable_roslyn_analysers = true,
          enable_import_completion = true,
          organize_imports_on_format = true,
          filetypes = { 'cs', 'vb', 'csproj', 'sln', 'slnx', 'props' },
        },
        lua_ls = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      }

      -- Setup neovim lua configuration
      require('neodev').setup()

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      -- Ensure the servers above are installed
      local mason_lspconfig = require 'mason-lspconfig'

      require'lspconfig'.rust_analyzer.setup {}

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
