return {
  {
    "stevearc/oil.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local oil = require("oil")
      local keymaps = require("user.keymaps")

      oil.setup({
        view_options = {
          show_hidden = true,
        },
      })
    end,
  }
}
