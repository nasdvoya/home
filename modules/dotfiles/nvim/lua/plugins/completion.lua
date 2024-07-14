return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'L3MON4D3/LuaSnip',             -- Snippet Engine & its associated nvim-cmp source
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lsp',         -- Adds LSP completion capabilities
    'rafamadriz/friendly-snippets', -- Adds a number of user-friendly snippets
  },
  config = function()
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    local keymaps = require('user.keymaps')
    require('luasnip.loaders.from_vscode').lazy_load()
    luasnip.config.setup {}
    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = keymaps.completion(cmp, luasnip),
      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
      },
    })
  end,
}
