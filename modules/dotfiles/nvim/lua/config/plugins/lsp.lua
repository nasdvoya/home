return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",
      {
        "folke/lazydev.nvim",
        opts = { library = { { path = "${3rd}/luv/library", words = { "vim%.uv" } } } },
      },
    },
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      local on_attach = function(client, bufnum)
        print("LSP attached to buffer: " .. bufnum)
        vim.api.nvim_buf_create_user_command(bufnum, "Format", function(_) vim.lsp.buf.format() end, { desc = "Format current byffer" })
      end

      -- Elixir (ElixirLS)
      require("lspconfig").elixirls.setup({
        cmd = { os.getenv("HOME") .. "/.nix-profile/bin/elixir-ls" },
        capabilities = capabilities,
        on_attach = on_attach,
        single_file_support = true,
      })

      -- Svelte
      require("lspconfig").svelte.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        single_file_support = true,
      })

      -- Lua
      require("lspconfig").lua_ls.setup({
        capabilites = capabilities,
        on_attach = on_attach,
      })

      -- Java (jdtls)
      require("lspconfig").jdtls.setup({
        cmd = { "jdtls" },
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          java = {
            configuration = {
              runtimes = {
                {
                  name = "JavaSE-21",
                  default = true,
                },
              },
            },
          },
        },
      })

      -- Htmx
      require("lspconfig")["htmx"].setup({
        cmd = { "htmx-lsp" },
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {},
        filetypes = {
          "aspnetcorerazor",
          "astro",
          "astro-markdown",
          "blade",
          "clojure",
          "django-html",
          "htmldjango",
          "edge",
          "erb",
          "eruby",
          "gohtml",
          "gohtmltmpl",
          "haml",
          "handlebars",
          "hbs",
          "html",
          "htmlangular",
          "html-eex",
          "heex",
          "jade",
          "leaf",
          "liquid",
          "markdown",
          "mdx",
          "mustache",
          "njk",
          "nunjucks",
          "php",
          "razor",
          "slim",
          "twig",
          "javascript",
          "javascriptreact",
          "reason",
          "rescript",
          "typescript",
          "typescriptreact",
          "vue",
          "templ",
        },
        root_dir = function(fname) return vim.fn.fnamemodify(fname, ":h") end,
        single_file_support = true,
      })

      -- Nix
      require("lspconfig")["nil_ls"].setup({
        cmd = { os.getenv("HOME") .. "/.nix-profile/bin/nil" },
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          ["nil"] = {
            formatting = {
              command = { "nixfmt" },
            },
          },
        },
        filetypes = { "nix" },
      })

      -- Bash
      require("lspconfig")["bashls"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {},
        filetypes = { "sh", "bash" },
      })

      -- Html
      require("lspconfig")["html"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {},
        filetypes = { "html", "svelte", "htmldjango", "htmljinja" },
      })

      -- Tailwind
      require("lspconfig")["tailwindcss"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {},
        filetypes = { "html" },
      })

      -- Rust
      require("lspconfig")["rust_analyzer"].setup({
        cmd = { "rust-analyzer" },
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          ["rust-analyzer"] = {
            diagnostics = {
              enable = true,
            },
            cargo = {
              allFeatures = true,
            },
          },
        },
        filetypes = { "rust" },
        root_dir = function(fname) return require("lspconfig.util").root_pattern("Cargo.toml", "rust-project.json")(fname) or vim.fn.fnamemodify(fname, ":h") end,
        single_file_support = true,
      })
    end,
  },
}
