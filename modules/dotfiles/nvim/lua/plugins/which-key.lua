return {
  "folke/which-key.nvim",
  opts = {},
  config = function()
    local wk = require('which-key')

    wk.register({
      { "<leader>c",  group = "[C]ode" },
      { "<leader>ca", group = "[C]ode [a]ction" },
      { "<leader>cr", group = "[R]un [c]ode" },
      { "<leader>d",  group = "[D]iagnostic and [d]ebugger" },
      { "<leader>g",  group = "[G]it" },
      { "<leader>h",  group = "[H]arpoon" },
      { "<leader>l",  group = "[L]azy git" },
      { "<leader>o",  group = "[O]bsidian and [oil]" },
      { "<leader>r",  group = "[R]ename" },
      { "<leader>s",  group = "[S]earch" },
      { "<leader>w",  group = "[W]orkspace" },
    }, { prefix = "<leader>" })

    wk.register({
      { "<leader>c_",  hidden = true },
      { "<leader>ca_", hidden = true },
      { "<leader>cr_", hidden = true },
      { "<leader>d_",  hidden = true },
      { "<leader>g_",  hidden = true },
      { "<leader>h_",  hidden = true },
      { "<leader>l_",  hidden = true },
      { "<leader>o_",  hidden = true },
      { "<leader>r_",  hidden = true },
      { "<leader>s_",  hidden = true },
      { "<leader>w_",  hidden = true },
    }, { prefix = "<leader>", hidden = true })
  end,
}
