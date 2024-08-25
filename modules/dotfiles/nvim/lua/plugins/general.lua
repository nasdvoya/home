return {
  {
    -- Documentation split
    "amrbashir/nvim-docs-view",
    lazy = true,
    cmd = "DocsViewToggle",
    opts = {
      position = "right",
      width = 60
    }
  },
  {
    -- Autopairs
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
  },
  {
    -- Keeps indentation style
    'tpope/vim-sleuth'
  },
  {
    -- Comments
    'numToStr/Comment.nvim',
    opts = {}
  },
  {
    -- Todo comments
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {}
  },
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
  },
  {
    "supermaven-inc/supermaven-nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = "<C-CR>"
        },
        color = {
          suggestion_color = "#6d7f8b",
          cterm = 244,
        },
      })
    end,
  },
}
