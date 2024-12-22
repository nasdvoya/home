return {
  {
    "supermaven-inc/supermaven-nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = "<C-CR>",
          accept_word = "<C-j>",
        },
        ignore_filetypes = { rust = true },
        color = {
          suggestion_color = "#6d7f8b",
          cterm = 244,
        },
        condition = function()
          return false 
        end,
      })
    end,
  },
}
