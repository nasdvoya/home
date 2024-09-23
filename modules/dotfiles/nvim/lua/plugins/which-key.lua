return {
  {
    "folke/which-key.nvim",
    opts = {
      icons = { rules = false, },
    },
    config = function()
      local wk = require('which-key')
      local keymaps = require("user.keymaps")
      keymaps.which_key(wk)
    end,
  }
}
