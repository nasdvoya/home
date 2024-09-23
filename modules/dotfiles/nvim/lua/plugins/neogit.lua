return {
  {
    "NeogitOrg/neogit",
    branch = "master",
    --tag = "v0.0.1",  -- Pin to a compatible version for Neovim 0.9.x
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional - Diff integration
      "nvim-telescope/telescope.nvim", -- optional
      "ibhagwan/fzf-lua",              -- optional
    },
    config = true
  }
}
