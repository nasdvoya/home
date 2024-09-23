local nnoremap = require("user.keymaps-helper").nnoremap
local vnoremap = require("user.keymaps-helper").vnoremap
local tnoremap = require("user.keymaps-helper").tnoremap

local M = {}

local TERM = os.getenv("TERM")

-- Normal --
nnoremap("L", "$", { desc = "Move to end of line and adjust cursor left" })
nnoremap("H", "^", { desc = "Move to beginning of line" })
nnoremap("<esc>", "<cmd>noh<cr>", { silent = true, desc = "Clear search highlights" })
nnoremap("<space>", "<nop>", { desc = "Disable Space bar" })
nnoremap("U", "<C-r>", { desc = "Redo the last undone change" })
nnoremap("<leader>w", "<cmd>w<cr>", { silent = false, desc = "Save current buffer" })
nnoremap("<leader>q", "<cmd>q<cr>", { silent = false, desc = "Quit current buffer" })
nnoremap("<leader>z", "<cmd>wq<cr>", { silent = false, desc = "Save and quit current buffer" })
nnoremap('k', "v:count == 0 ? 'gk' : 'k'",
  { expr = true, silent = true, desc = "Move up visually with 'k', handle wrapped lines" })
nnoremap('j', "v:count == 0 ? 'gj' : 'j'",
  { expr = true, silent = true, desc = "Move down visually with 'j', handle wrapped lines" })
-- Find/replacs
nnoremap("S", function()
  local cmd = ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>"
  local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
  vim.api.nvim_feedkeys(keys, "n", false)
end)

-- Visual --
vnoremap("<space>", "<nop>", { desc = "Disable Space bar" })
vnoremap("L", "$<left>", { desc = "Move to end of line and adjust cursor left" })
vnoremap("H", "^", { desc = "Move to beginning of line" })
vnoremap("<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down and reselect" })
vnoremap("<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up and reselect" })

-- Terminal --
-- Enter normal mode while in a terminal
tnoremap("<esc>", [[<C-\><C-n>]], { desc = "Terminal: Exit to normal mode" })
tnoremap("<space>", "<space>", { desc = "Terminal: Reenable default space functionality" })

-- Diagnostics
function YankDiagnosticError()
  vim.diagnostic.open_float()
  vim.diagnostic.open_float()
  local win_id = vim.fn.win_getid()    -- get the window ID of the floating window
  vim.cmd("normal! j")                 -- move down one row
  vim.cmd("normal! VG")                -- select everything from that row down
  vim.cmd("normal! y")                 -- yank selected text
  vim.api.nvim_win_close(win_id, true) -- close the floating window by its ID
end

-- Mapping the function to a key combination
nnoremap('<leader>dy', ":lua YankDiagnosticError()<CR>", { desc = 'Yank diagnostic error' })
nnoremap("<leader>dn", function()
  vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
  vim.api.nvim_feedkeys("zz", "n", false)
end, { desc = 'Goto [n]ext error' })
nnoremap("<leader>dp", function()
  vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
  vim.api.nvim_feedkeys("zz", "n", false)
end, { desc = 'Goto [p]revious error' })


-- Plugins --

-- Telescope keybinds
local telescope_b = require('telescope.builtin')
nnoremap('<leader>st', '<cmd>TodoTelescope<cr>', { desc = '[S]earch todo notes' })
nnoremap('<leader>?', telescope_b.oldfiles, { desc = "[?] Find recently opened files" })
nnoremap('<leader><space>', telescope_b.buffers, { desc = "[S]earch Open [b]uffers" })
nnoremap('<leader>sh', telescope_b.help_tags, { desc = "[S]earch [h]elp" })
nnoremap('<leader>sg', telescope_b.live_grep, { desc = "[S]earch by [g]rep" })
nnoremap('<leader>sw', telescope_b.grep_string, { desc = '[S]earch current [w]ord' })
nnoremap('<leader>sd', telescope_b.diagnostics, { desc = '[S]earch [d]iagnostics' })
nnoremap("<leader>sf", function()
  telescope_b.find_files({ hidden = true })
end, { desc = "[S]earch [f]iles" })

nnoremap("<leader>sc", function()
  telescope_b.commands(require("telescope.themes").get_dropdown({
    previewer = false,
  }))
end, { desc = "[S]earch [c]ommands" })

nnoremap("<leader>/", function()
  telescope_b.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
    previewer = true,
    winblend = 10,
  }))
end, { desc = "[/] Fuzzily search in current buffer]" })

-- Completion
M.completion = function(cmp, luasnip)
  return cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }
end

-- Navigation
nnoremap('<leader>e', ':Neotree toggle<CR>', { desc = 'Toggle file tree [e]explorer' })
nnoremap("<leader>oi", function()
  require("oil").toggle_float()
end, { desc = "[O]il [f]ile managment" })

-- LSP
M.common_lsp = function(buffer_number)
  nnoremap("<leader>cr", vim.lsp.buf.rename, { desc = "LSP: [R]e[n]ame", buffer = buffer_number })
  nnoremap("<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: [C]ode [a]ction", buffer = buffer_number })

  -- Telescope LSP keybinds
  nnoremap("<leader>cs", require("telescope.builtin").lsp_document_symbols,
    { desc = "LSP: [B]uffer [S]ymbols", buffer = buffer_number })
  nnoremap("<leader>cps", require("telescope.builtin").lsp_workspace_symbols,
    { desc = "LSP: [P]roject [S]ymbols", buffer = buffer_number })
  -- See `:help K` for why this keymap
  nnoremap("<leader>cd", vim.lsp.buf.hover, { desc = "LSP: [C]ode [d]ocumentation", buffer = buffer_number })

  -- Lesser used LSP functionality
  nnoremap("gD", vim.lsp.buf.declaration, { desc = "LSP: [G]oto [d]eclaration", buffer = buffer_number })
end

-- Default LSP
M.default_lsp = function(buffer_number)
  M.common_lsp(buffer_number)
  nnoremap("gd", vim.lsp.buf.definition, { desc = "LSP: [G]oto [d]efinition", buffer = buffer_number })
  nnoremap("gr", require("telescope.builtin").lsp_references,
    { desc = "LSP: [G]oto [R]eferences", buffer = buffer_number })
  nnoremap("gi", require("telescope.builtin").lsp_implementations,
    { desc = "LSP: [G]oto [I]mplementation", buffer = buffer_number })
  nnoremap("td", vim.lsp.buf.type_definition, { desc = "LSP: [T]ype [d]efinition", buffer = buffer_number })
  nnoremap("<leader>k", vim.lsp.buf.signature_help, { desc = "LSP: Signature Documentation", buffer = buffer_number })
end

-- OmniSharp LSP
M.omnisharp = function(buffer_number)
  M.common_lsp(buffer_number)
  nnoremap("gd", "<cmd>lua require('omnisharp_extended').lsp_definition()<cr>",
    { desc = "LSP: [G]oto [d]efinition", buffer = buffer_number })
  nnoremap("gr", "<cmd>lua require('omnisharp_extended').lsp_references()<cr>",
    { desc = "LSP: [G]oto [R]eferences", buffer = buffer_number })
  nnoremap("gi", "<cmd>lua require('omnisharp_extended').lsp_implementation()<cr>",
    { desc = "LSP: [G]oto [I]mplementation", buffer = buffer_number })
  nnoremap("<leader>D", "<cmd>lua require('omnisharp_extended').lsp_type_definition()<cr>",
    { desc = "LSP: [t]ype [d]efinition", buffer = buffer_number })
end

-- Documentantion Toggle
nnoremap("<leader>ct", "<cmd>DocsViewToggle<CR>", { desc = "Toggle docs view" })

-- Obsidian
vim.keymap.set("n", "<leader>on", function()
  vim.cmd("ObsidianTemplate note")
  vim.cmd("1,/^\\S/s/^\\n\\{1,}//e")
end, { desc = '[O]bsidian [n]ote' })

-- Keymap to grep search obsidian notes
vim.keymap.set("n", "<leader>sog", function()
  local query = vim.fn.input("Obsidian Search Query: ")
  vim.cmd("ObsidianSearch " .. query)
end, { desc = '[S]earch [o]bsidian notes by [g]rep ' })

-- Keymap to search obsidian notes
vim.keymap.set("n", "<leader>son", function()
  vim.cmd("ObsidianQuickSwitch")
end, { desc = '[S]earch [o]bsidian notes' })

-- WhichKey
M.which_key = function(wk)
  wk.add({
    -- Top-level groups
    { "<leader>c",        group = "Code actions" },
    { "<leader>d",        group = "Diagnostic" },
    { "<leader>g",        group = "Git" },
    { "<leader>gt",       group = "Git [T]oggles" },
    { "<leader>s",        group = "Search" },
    { "<leader>o",        group = "Obsidian and oil" },
    { "<leader>gh",       group = "Hunk operations" },
    { "<leader>so",       group = "[S]earch [o]bsidian" },
    -- hidden
    { "<leader>q",        hidden = true },
    { "<leader>f",        hidden = true },
    { "<leader><leader>", hidden = true },
    { "<leader>w",        hidden = true },
    { "<leader>ng",       hidden = true },
    { "<leader>z",        hidden = true },
    { "<leader>l",        hidden = true },

  })
end

-- Gitsigns
M.gitsigns = function(gs, bufnr)
  nnoremap('<leader>gS', gs.stage_buffer, { desc = 'Git Stage buffer' })
  nnoremap('<leader>gR', gs.reset_buffer, { desc = 'Git Reset buffer' })
  nnoremap('<leader>gd', gs.diffthis, { desc = 'Git diff against index' })
  nnoremap('<leader>gD', function()
    gs.diffthis '~'
  end, { desc = 'Git diff against last commit' })

  -- Toggles
  nnoremap('<leader>gtb', gs.toggle_current_line_blame, { desc = 'Toggle git blame line' })
  nnoremap('<leader>gtd', gs.toggle_deleted, { desc = 'Toggle git show deleted' })
end

-- Lazygit
nnoremap("<leader>lg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })

-- Neogit
local neogit = require('neogit')
nnoremap('<leader>ng', neogit.open, { desc = 'Neogit' })
nnoremap('<leader>gc', ':Neogit commit<CR>', { desc = 'Neogit Commit', silent = true, noremap = true })
nnoremap('<leader>gp', ':Neogit pull<CR>', { desc = 'Neogit Pull', silent = true, noremap = true })
nnoremap('<leader>gP', ':Neogit push<CR>', { desc = 'Neogit Push', silent = true, noremap = true })

-- Dap
local dap = require('dap')
local dapui = require('dapui')

nnoremap('<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
nnoremap('<F10>', dap.step_over, { desc = 'Debug: Step Over' })
nnoremap('<F11>', dap.step_into, { desc = 'Debug: Step Into' })
nnoremap('<S-F11>', dap.step_out, { desc = 'Debug: Step Out' })
nnoremap('<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
nnoremap('<F7>', dapui.toggle, { desc = 'Debug: See last session result' })

-- Treesitter
local ts_incremental_selection = require('nvim-treesitter.incremental_selection')
nnoremap('<c-space>', ts_incremental_selection.init_selection, { desc = 'Treesitter: Init selection' })
vnoremap('<c-space>', ts_incremental_selection.node_incremental, { desc = 'Treesitter: Node incremental' })

return M
