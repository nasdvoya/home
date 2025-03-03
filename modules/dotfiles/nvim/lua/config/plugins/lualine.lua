return {
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "transparent",
          component_separators = "",
          section_separators = "",
        },
        sections = {
          lualine_a = { { "mode" } },
          lualine_b = { { "branch", color = { bg = "NONE" } }, { "diff", color = { bg = "NONE" } }, { "diagnostics", color = { bg = "NONE" } } },
          lualine_c = { { "filename", color = { bg = "NONE" } } },
          lualine_x = {
            { "encoding", color = { bg = "NONE" } },
            { "fileformat", color = { bg = "NONE" } },
            { "filetype", color = { bg = "NONE" } },
          },
          lualine_y = { { "progress", color = { bg = "NONE" } } },
          lualine_z = { { "location" } },
        },
      })
    end,
  },
}
