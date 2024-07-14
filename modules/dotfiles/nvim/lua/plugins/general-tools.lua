return {
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
      notify = false, -- Disable warnings about issues detected with your mappings
    },
    config = function()
      local wk = require('which-key')
      local keymaps = require("user.keymaps")
      keymaps.which_key(wk)
    end,
  },
  {
    {
      "Exafunction/codeium.vim",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
      },
      commit = "289eb724e5d6fab2263e94a1ad6e54afebefafb2",
      event = "BufEnter",
      config = function()
        -- not using tab to complete
        vim.g.codeium_disable_bindings = 1
      end,
    },
  }
}
