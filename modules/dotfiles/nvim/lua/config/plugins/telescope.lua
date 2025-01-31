return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "tpope/vim-fugitive",
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release" },
    "isak102/telescope-git-file-history.nvim",
  },
  config = function()
    local gfh_actions = require("telescope").extensions.git_file_history.actions
    require("telescope").setup({
      vim.keymap.set(
        "n",
        "<leader>sw",
        function() require("telescope.builtin").grep_string(require("telescope.themes").get_ivy({ border = false, winblend = 20, layout_config = { preview_cutoff = 50 } })) end,
        { desc = "Search open buffers" }
      ),
      vim.keymap.set(
        "n",
        "<leader><space>",
        function() require("telescope.builtin").buffers(require("telescope.themes").get_ivy({ border = false, winblend = 20, layout_config = { preview_cutoff = 50 } })) end,
        { desc = "Search open buffers" }
      ),
      vim.keymap.set(
        "n",
        "<leader>sg",
        function() require("telescope.builtin").live_grep(require("telescope.themes").get_ivy({ border = false, winblend = 20, layout_config = { preview_cutoff = 50 } })) end,
        { desc = "Search grep" }
      ),
      vim.keymap.set(
        "n",
        "<leader>sf",
        function() require("telescope.builtin").find_files(require("telescope.themes").get_ivy({ border = false, winblend = 20, layout_config = { preview_cutoff = 50 } })) end,
        { desc = "Search files" }
      ),
      vim.keymap.set(
        "n",
        "<leader>sc",
        function() require("telescope.builtin").commands(require("telescope.themes").get_ivy({ border = false, winblend = 20, layout_config = { preview_cutoff = 50 } })) end,
        { desc = "Search commands" }
      ),
      vim.keymap.set(
        "n",
        "<leader>sd",
        function() require("telescope.builtin").diagnostics(require("telescope.themes").get_ivy({ border = false, winblend = 20, layout_config = { preview_cutoff = 50 } })) end,
        { desc = "Search diagnostics" }
      ),
      vim.keymap.set(
        "n",
        "<leader>sh",
        function() require("telescope").extensions.git_file_history.git_file_history(require("telescope.themes").get_ivy({ border = false, winblend = 20, layout_config = { preview_cutoff = 50 } })) end,
        { desc = "Search git file git file history" }
      ),
      vim.keymap.set(
        "n",
        "<leader>/",
        function() require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_ivy({ border = false })) end,
        { desc = "Fuzzy find current file" }
      ),
      vim.keymap.set(
        "n",
        "<leader>sr",
        function() require("telescope.builtin").lsp_references(require("telescope.themes").get_ivy({ border = false, winblend = 20, layout_config = { preview_cutoff = 50 } })) end,
        { desc = "Find references" }
      ),
      vim.keymap.set("n", "<leader>st", "<cmd>TodoTelescope<cr>", { desc = "Search TODOs" }),
      defaults = {},
      pickers = {
        live_grep = {
          file_ignore_patterns = { "node_modules", ".git/" },
          hidden = true,
        },
        find_files = {
          file_ignore_patterns = { "node_modules", ".git/" },
          hidden = true,
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
        extensions = {
          git_file_history = {
            -- Keymaps inside the picker
            mappings = {
              i = {
                ["<C-g>"] = gfh_actions.open_in_browser,
              },
              n = {
                ["<C-g>"] = gfh_actions.open_in_browser,
              },
            },
            -- The command to use for opening the browser (nil or string)
            -- If nil, it will check if xdg-open, open, start, wslview are available, in that order.
            browser_command = nil,
          },
        },
      },
    })
    require("telescope").load_extension("fzf")
  end,
}
