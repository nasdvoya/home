return {
  "supermaven-inc/supermaven-nvim",
  config = function()
    require("supermaven-nvim").setup({
      keymaps = {
        accept_word = "<leader>y",
      },
      ignore_filetypes = { rust = true, nix = true },
    })
  end,
}
