return {
  -- Theme
  {
    "steguiosaur/fullerene.nvim",
    config = function()
      require("fullerene").setup({
        options = {
        },
      })
      vim.cmd [[colorscheme fullerene]]
    end
  },
  {
    -- Status line
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = true,
        theme = 'fullerene',
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
