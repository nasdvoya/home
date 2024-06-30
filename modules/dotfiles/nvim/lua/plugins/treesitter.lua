return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects', },
  build = ':TSUpdate',
  config = function()
    vim.defer_fn(function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          'c',
          'cpp',
          'bash',
          'markdown',
          'css',
          'go',
          'lua',
          'python',
          'rust',
          'tsx',
          'javascript',
          'typescript',
          'vimdoc',
          'vim',
          'c_sharp',
          'json',
          'nix',
          'html'
        },

        auto_install = true,
        autotag = { enable = true },
        autopairs = { enable = true },
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<c-space>',
            node_incremental = '<c-space>',
            scope_incremental = '<c-s>',
            node_decremental = '<M-space>',
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
            },
          },
        },
      }
    end, 0)
  end
}
