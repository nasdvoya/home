return {
  {
    -- Theme
    "HoNamDuong/hybrid.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      require("hybrid").setup({
        terminal_colors = true,
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = false,
          emphasis = true,
          comments = true,
          folds = true,
        },
        strikethrough = true,
        inverse = true,
        transparent = true,

        overrides = function(hl, c)
          local background = "#1d1f21"
          hl.TelescopeNormal = {
            fg = c.fg,
            bg = background,
          }
          hl.TelescopeBorder = {
            fg = c.fg_hard,
            bg = c.bg,
          }
          hl.TelescopeTitle = {
            fg = c.fg_hard,
            bg = c.bg,
            bold = true,
          }
        end,
      })
      vim.cmd [[colorscheme hybrid]]
    end,
  },
  {
    -- Indentation lines
    "shellRaining/hlchunk.nvim",
    event = { "UIEnter" },
    config = function()
      require("hlchunk").setup({
        chunk = {
          chars = {
            horizontal_line = "─",
            vertical_line = "│",
            left_top = "┌",
            left_bottom = "└",
            right_arrow = "─",
          },
        },
        indent = { enable = true },
        blank = {
          enable = true,
          chars = {
            " ",
          },
        }
      })
    end,
  },
  {
    -- Status line
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = true,
        theme = 'hybrid',
        component_separators = '|',
        section_separators = '',
      },
    },
  },
}