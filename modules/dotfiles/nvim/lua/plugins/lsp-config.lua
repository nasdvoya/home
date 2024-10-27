return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim',          config = true },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'j-hui/fidget.nvim',                tag = 'legacy', opts = {} },
      { 'folke/neodev.nvim' }
    },
    config = function()
      local keymaps = require("user.keymaps")
      local mason_lspconfig = require 'mason-lspconfig'
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
      require('neodev').setup()
      local on_attach = function(client, buffer_number)
        if client.name == "omnisharp" then
          keymaps.omnisharp(buffer_number)
        else
          keymaps.default_lsp(buffer_number)
        end
        vim.api.nvim_buf_create_user_command(buffer_number, 'Format', function(_)
          vim.lsp.buf.format()
        end, { desc = 'Format current buffer with LSP' })
      end
      local servers = {
        -- default installed servers
      }
      -- Mason LSP
      mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(servers),
      }

      -- Mason LSP Handlers
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

      -- Manual setup

      require('lspconfig')['htmx'].setup {
        cmd = { "htmx-lsp" },
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {},
        filetypes = {
          "aspnetcorerazor", "astro", "astro-markdown", "blade", "clojure", "django-html", "htmldjango", "edge", "eelixir", "elixir", "ejs", "erb", "eruby",
          "gohtml", "gohtmltmpl", "haml", "handlebars", "hbs", "html", "htmlangular", "html-eex", "heex", "jade", "leaf", "liquid", "markdown", "mdx",
          "mustache", "njk", "nunjucks", "php", "razor", "slim", "twig", "javascript", "javascriptreact", "reason", "rescript", "typescript",
          "typescriptreact", "vue", "svelte", "templ"
        },
        root_dir = function(fname)
          return vim.fn.fnamemodify(fname, ':h')
        end,
        single_file_support = true,
      }

      require('lspconfig')['lua_ls'].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
        filetypes = { 'lua' },
      }
      require('lspconfig')['omnisharp'].setup {
        cmd = { "/etc/profiles/per-user/" .. os.getenv("USER") .. "/bin/OmniSharp" },
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          enable_roslyn_analysers = true,
          enable_import_completion = true,
          organize_imports_on_format = true,
        },
        filetypes = { 'cs', 'vb', 'csproj', 'sln', 'slnx', 'props' },
      }
      require('lspconfig')['nil_ls'].setup {
        cmd = { "/etc/profiles/per-user/" .. os.getenv("USER") .. "/bin/nil" },
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          ['nil'] = {
            formatting = {
              command = { "nixfmt" },
            },
          },
        },
        filetypes = { 'nix' },
      }
      require('lspconfig')['gopls'].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {},
        filetypes = { 'go' },
      }
      require('lspconfig')['html'].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {},
        filetypes = { 'html', 'htmldjango', 'htmljinja' },
      }
      require('lspconfig')['tailwindcss'].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {},
        filetypes = { 'html' },
      }
      require('lspconfig')['rust_analyzer'].setup {
        cmd = { "rust-analyzer" },
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          ['rust-analyzer'] = {
            diagnostics = {
              enable = true,
            },
            cargo = {
              allFeatures = true,
            },
          }
        },
        filetypes = { 'rust' },
        root_dir = function(fname)
          return require('lspconfig.util').root_pattern("Cargo.toml", "rust-project.json")(fname) or
              vim.fn.fnamemodify(fname, ':h')
        end,
        single_file_support = true,
      }
      require('lspconfig')['unison'].setup {
        on_attach = function(client, bufnr)
          vim.o.signcolumn = 'yes'
          vim.o.updatetime = 250
          vim.diagnostic.config({ virtual_text = false })

          vim.api.nvim_create_autocmd("CursorHold", {
            buffer = bufnr,
            callback = function()
              local opts = {
                focusable = false,
                close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                border = 'rounded',
                source = 'always',
                prefix = ' ',
                scope = 'cursor',
              }
              vim.diagnostic.open_float(nil, opts)
            end,
          })
        end,
      }
    end,
  }
}
