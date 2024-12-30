return {
  "nvim-telescope/telescope.nvim",
  tag = '0.1.8',
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' }
  },
  config = function()
    require("telescope").setup {
      vim.keymap.set("n", "<leader>sw", function()
        require("telescope.builtin").grep_string(require("telescope.themes").get_ivy({ border = false, winblend = 20, layout_config = { preview_cutoff = 50 } }))
      end, { desc = "Search open buffers" }),
      vim.keymap.set("n", "<leader><space>", function()
        require("telescope.builtin").buffers(require("telescope.themes").get_ivy({ border = false, winblend = 20, layout_config = { preview_cutoff = 50 } }))
      end, { desc = "Search open buffers" }),
      vim.keymap.set("n", "<leader>sg", function()
        require("telescope.builtin").live_grep(require("telescope.themes").get_ivy({ border = false, winblend = 20, layout_config = { preview_cutoff = 50 } }))
      end, { desc = "Search grep" }),
      vim.keymap.set("n", "<leader>sf", function()
        require("telescope.builtin").find_files(require("telescope.themes").get_ivy({ border = false, winblend = 20, layout_config = { preview_cutoff = 50 } }))
      end, { desc = "Search files" }),
      vim.keymap.set("n", "<leader>sc", function()
        require("telescope.builtin").commands(require("telescope.themes").get_ivy({ border = false, winblend = 20, layout_config = { preview_cutoff = 50 } }))
      end, { desc = "Search commands" }),
      vim.keymap.set("n", "<leader>sd", function()
        require("telescope.builtin").diagnostics(require("telescope.themes").get_ivy({ border = false, winblend = 20, layout_config = { preview_cutoff = 50 } }))
      end, { desc = "Search open buffers" }),
      vim.keymap.set("n", "<leader>/", function()
        require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_ivy({ border = false }))
      end, { desc = "Fuzzy find current file" }),
      vim.keymap.set("n", "<leader>st", "<cmd>TodoTelescope<cr>", { desc = "Search TODOs" }),
      defaults = {
      },
      pickers = {
        live_grep = {
          file_ignore_patterns = { 'node_modules', '.git/' },
          hidden = true
        },
        find_files = {
          file_ignore_patterns = { 'node_modules', '.git/' },
          hidden = true
        }

      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        }
      }
    }
    require('telescope').load_extension('fzf')
  end,
}
