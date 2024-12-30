return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      'saghen/blink.cmp',
      {
        "folke/lazydev.nvim",
        opts = { library = { { path = "${3rd}/luv/library", words = { "vim%.uv" } }, }, },
      },
    },
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      local keymaps = require("config.keymaps")

      local on_attach = function(client, bufnum)
        print("LSP attached to buffer: " .. bufnum)
        keymaps.common_lsp(bufnum)
        vim.api.nvim_buf_create_user_command(bufnum, "Format", function(_)
          vim.lsp.buf.format()
        end, { desc = "Format current byffer" })
      end

      -- Dotnet
      require("lspconfig")["omnisharp"].setup {
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

      -- Lua
      require("lspconfig").lua_ls.setup {
        capabilites = capabilities,
        on_attach = on_attach
      }

      -- Htmx
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

      -- Nix
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

      -- Bash
      require('lspconfig')['bashls'].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {},
        filetypes = { 'sh', 'bash' },
      }

      -- Html
      require('lspconfig')['html'].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {},
        filetypes = { 'html', 'htmldjango', 'htmljinja' },
      }

      -- Tailwind
      require('lspconfig')['tailwindcss'].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {},
        filetypes = { 'html' },
      }

      -- Rust
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

      --

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end

          -- Format the current buffer on save
          if vim.bo.filetype == "lua" then
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
              end,
            })
          end
        end,
      })
    end,
  }
}
