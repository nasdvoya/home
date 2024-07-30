return {
  -- Theme
  {
    "EdenEast/nightfox.nvim",
    config = function()
      require("nightfox").setup({
        options = {
          transparent = true,
        },
      })
      vim.cmd [[colorscheme carbonfox]]
    end
  },
  {
    -- Status line
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = true,
        theme = 'carbonfox',
        component_separators = '|',
        section_separators = '',
      },
    },
  },
  {
    "shellRaining/hlchunk.nvim",

    config = function()
      require("hlchunk").setup({
        chunk = {
          chars = {
            horizontal_line = "─",
            vertical_line = "│",
            left_top = "╭",
            left_bottom = "╰",
            right_arrow = ">",
          },
          style = "#806d9c",
        },
      })
    end
  },
}
