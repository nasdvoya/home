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
    opts = {
    }
  },
  {
    "folke/which-key.nvim",
    opts = {
      notify = false, -- Disable warnings about issues detected with your mappings
    },
    config = function()
      local wk = require('which-key')

      wk.register({
        ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
        ['<leader>d'] = { name = '[D]iagnostic and [d]ebugger', _ = 'which_key_ignore' },
        ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
        ['<leader>h'] = { name = '[H]arpoon', _ = 'which_key_ignore' },
        ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
        ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
        ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
        ['<leader>cr'] = { name = '[R]un [c]ode', _ = 'which_key_ignore' },
        ['<leader>ca'] = { name = '[C]ode [a]ction', _ = 'which_key_ignore' },
        ['<leader>o'] = { name = '[O]bsidian and [O]il', _ = 'which_key_ignore' },
        ['<leader>l'] = { name = '[L]azy git', _ = 'which_key_ignore' },
      })
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
