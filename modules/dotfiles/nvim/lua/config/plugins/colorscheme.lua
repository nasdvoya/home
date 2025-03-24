return {
  {
    "Skardyy/makurai-nvim",
    config = function()
      require("makurai").setup({
        transparent = true,
      })
      vim.cmd.colorscheme("makurai")
    end,
  },
}
