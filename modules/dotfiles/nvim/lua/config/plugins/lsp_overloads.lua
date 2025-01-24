return {
  "Issafalcon/lsp-overloads.nvim",
  config = function()
    local overloads = require('lsp-overloads')
    overloads.setup({
      display_automatically = true -- Automatically show signature help
    })
    -- Key mapping for signature help and scrolling through overloads
    vim.keymap.set("n", "<leader>k", function()
      if overloads.is_signature_help_visible() then
        overloads.next_signature()
      else
        vim.lsp.buf.signature_help()
      end
    end, { desc = "Toggle or scroll through signature help" })
  end
}
