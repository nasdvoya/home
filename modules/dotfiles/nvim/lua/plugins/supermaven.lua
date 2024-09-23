return {
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
