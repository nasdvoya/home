return {
  "stevearc/conform.nvim",
  opts = {},
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        rust = { "rustfmt", lsp_format = "fallback" },
        cs = { "csharpier" },
        just = { "just" },
        nix = { "alejandra" },
        -- Web stuff
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        json = { "prettierd", "prettier", stop_after_first = true },
        jsonc = { "prettierd", "prettier", stop_after_first = true },
        yaml = { "prettierd", "prettier", stop_after_first = true },
        html = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettierd", "prettier", stop_after_first = true },
        scss = { "prettierd", "prettier", stop_after_first = true },
        less = { "prettierd", "prettier", stop_after_first = true },
        markdown = { "prettierd", "prettier", stop_after_first = true },
        graphql = { "prettierd", "prettier", stop_after_first = true },
      },
    })

    vim.keymap.set("n", "<leader>cf", function()
      require("conform").format({
        lsp_fallback = true, -- Use LSP formatting if no formatter is configured
        async = false, -- Run synchronously (set to true if you prefer async)
        timeout_ms = 3000, -- Timeout in milliseconds
      })
    end, { desc = "Format buffer with Conform" })
  end,
}
