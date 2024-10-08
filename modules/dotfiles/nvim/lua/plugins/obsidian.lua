return {
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
      "nvim-telescope/telescope.nvim",
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      workspaces = {
        {
          name = "work",
          path = "~/Github/notes",
        },
      },
      completion = {
        nvim_cmp = true,
        min_chars = 2,
      },
      templates = {
        folder = "templates",
        date_format = "%Y-%m-%d-%a",
        time_format = "%H:%M",
      },
      disable_frontmatter = true,
      notes_subdir = "inbox",
      new_notes_location = "notes_subdir",
    },
  }
}
