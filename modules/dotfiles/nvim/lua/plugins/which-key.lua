return {
  "folke/which-key.nvim",
  opts = {
  },
  config = function()
    local wk = require('which-key')

    wk.register({
      ['<leader>c'] = { name = '[c]ode', _ = 'which_key_ignore' },
      ['<leader>d'] = { name = '[d]iagnostic and [d]ebugger', _ = 'which_key_ignore' },
      ['<leader>g'] = { name = '[g]it', _ = 'which_key_ignore' },
      ['<leader>h'] = { name = '[h]arpoon', _ = 'which_key_ignore' },
      ['<leader>r'] = { name = '[r]ename', _ = 'which_key_ignore' },
      ['<leader>s'] = { name = '[s]earch', _ = 'which_key_ignore' },
      ['<leader>w'] = { name = '[w]orkspace', _ = 'which_key_ignore' },
      ['<leader>cr'] = { name = 'Run code', _ = 'which_key_ignore' },
      ['<leader>ca'] = { name = 'Code action', _ = 'which_key_ignore' },
    })
  end,
}
