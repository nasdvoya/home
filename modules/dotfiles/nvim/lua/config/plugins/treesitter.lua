return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = {
          'c', 'cpp', 'bash', 'markdown', 'css', 'go', 'lua',
          'python', 'rust', 'tsx', 'javascript', 'typescript',
          'vimdoc', 'vim', 'c_sharp', 'json', 'nix', 'html',
          'yaml', 'toml', 'dockerfile', 'just'
        },
        sync_install = false,
        auto_install = false,
        modules = {},
        ignore_install = {},
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<c-l>",     -- Start incremental selection
            node_incremental = "<c-l>",   -- Increment to the next node
            scope_incremental = "<c-s>",  -- Increment to the next scope
            node_decremental = "<c-s-l>", -- Decrement to the previous node
          },
        },
        highlight = {
          enable = true,
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
          additional_vim_regex_highlighting = false,
        },
      }
    end,
  }
}
