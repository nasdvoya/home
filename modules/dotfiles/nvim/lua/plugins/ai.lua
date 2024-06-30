return {
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
