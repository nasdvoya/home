local nnoremap = require("user.keymaps-helper").nnoremap
local vnoremap = require("user.keymaps-helper").vnoremap
local inoremap = require("user.keymaps-helper").inoremap
local tnoremap = require("user.keymaps-helper").tnoremap
local xnoremap = require("user.keymaps-helper").xnoremap

local M = {}

local TERM = os.getenv("TERM")

nnoremap("<space>", "<nop>", { desc = "Disable Space bar" })
vnoremap("<space>", "<nop>", { desc = "Disable Space bar" })
nnoremap("U", "<C-r>", { desc = "Redo the last undone change" })
nnoremap("<leader>w", "<cmd>w<cr>", { silent = false, desc = "Save current buffer" })
nnoremap("<leader>q", "<cmd>q<cr>", { silent = false, desc = "Quit current buffer" })
nnoremap("<leader>z", "<cmd>wq<cr>", { silent = false, desc = "Save and quit current buffer" })

-- Navigation
nnoremap('<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle file tree [e]explorer' })
nnoremap("<leader>oi", function()
  require("oil").toggle_float()
end, { desc = "[O]il [f]ile managment" })

nnoremap('k', "v:count == 0 ? 'gk' : 'k'",
  { expr = true, silent = true, desc = "Move up visually with 'k', handle wrapped lines" })
nnoremap('j', "v:count == 0 ? 'gj' : 'j'",
  { expr = true, silent = true, desc = "Move down visually with 'j', handle wrapped lines" })

-- Center buffer while navigating
nnoremap("<C-u>", "<C-u>zz", { desc = "Scroll up and center buffer" })
nnoremap("<C-d>", "<C-d>zz", { desc = "Scroll down and center buffer" })
nnoremap("{", "{zz", { desc = "Move to previous paragraph and center buffer" })
nnoremap("}", "}zz", { desc = "Move to next paragraph and center buffer" })
nnoremap("N", "Nzz", { desc = "Move to previous search match and center buffer" })
nnoremap("n", "nzz", { desc = "Move to next search match and center buffer" })
nnoremap("G", "Gzz", { desc = "Move to end of file and center buffer" })
nnoremap("gg", "ggzz", { desc = "Move to beginning of file and center buffer" })
nnoremap("<C-i>", "<C-i>zz", { desc = "Go forward in jump list and center buffer" })
nnoremap("<C-o>", "<C-o>zz", { desc = "Go backward in jump list and center buffer" })
-- Find stuff (:noh clears). Need better keymap for this
nnoremap("%", "%zz", { desc = "Jump to matching pair and center buffer" })
nnoremap("*", "*zz", { desc = "Search forward for word under cursor and center buffer" })
nnoremap("#", "#zz", { desc = "Search backward for word under cursor and center buffer" })

-- Press 'S' for quick find/replace for the word under the cursor
nnoremap("S", function()
  local cmd = ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>"
  local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
  vim.api.nvim_feedkeys(keys, "n", false)
end)

-- AI
inoremap("<C-CR>", function()
  return vim.fn["codeium#Accept"]()
end, { expr = true, silent = true, desc = "AI chat accept" })

nnoremap("<leader>a", function()
  return vim.fn["codeium#Chat"]()
end, { expr = true, silent = true, desc = "AI chat" })

-- Diagnostics

nnoremap('<leader>dl', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

nnoremap('<leader>dna', function()
  vim.diagnostic.goto_next({})
  vim.api.nvim_feedkeys("zz", "n", false)
end, { desc = 'Goto [n]ext diagnostic of [a]ny severity' })

nnoremap('<leader>dpa', function()
  vim.diagnostic.goto_pev({})
  vim.api.nvim_feedkeys("zz", "n", false)
end, { desc = 'Goto [p]revious diagnostic of [a]ny severity' })

nnoremap("<leader>dn", function()
  vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
  vim.api.nvim_feedkeys("zz", "n", false)
end, { desc = 'Goto [n]ext error' })

nnoremap("<leader>dp", function()
  vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
  vim.api.nvim_feedkeys("zz", "n", false)
end, { desc = 'Goto [p]revious error' })

nnoremap('<leader>dnw', function()
  vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
  vim.api.nvim_feedkeys("zz", "n", false)
end, { desc = 'Goto [n]ext [w]arning' })

nnoremap('<leader>dpw', function()
  vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })
  vim.api.nvim_feedkeys("zz", "n", false)
end, { desc = 'Goto [p]revious [w]arning' })

nnoremap("<leader>d", function()
  vim.diagnostic.open_float({
    border = "rounded",
  })
end, { desc = 'Diagnos under cursor' })

-- Press leader f to format
nnoremap("<leader>f", ":Format<cr>")

-- Press gx to open the link under the cursor
nnoremap("gx", ":sil !open <cWORD><cr>", { silent = true })

-- Git keymaps --
nnoremap("<leader>gb", ":Gitsigns toggle_current_line_blame<cr>")
nnoremap("<leader>gf", function()
  local cmd = {
    "sort",
    "-u",
    "<(git diff --name-only --cached)",
    "<(git diff --name-only)",
    "<(git diff --name-only --diff-filter=U)",
  }
end, { desc = "Search [g]it [f]iles" })

-- Telescope keybinds --
local telescope_b = require('telescope.builtin')
nnoremap('<leader>st', '<cmd>TodoTelescope<cr>', { desc = '[?] [s]earch todo notes' })
nnoremap('<leader>?', telescope_b.oldfiles, { desc = "[?] Find recently opened files" })
nnoremap('<leader><space>', telescope_b.buffers, { desc = "[s]earch Open [b]uffers" })
nnoremap('<leader>sh', telescope_b.help_tags, { desc = "[s]earch [h]elp" })
nnoremap('<leader>sg', telescope_b.live_grep, { desc = "[s]earch by [g]rep" })
nnoremap('<leader>sw', telescope_b.grep_string, { desc = '[s]earch current [w]ord' })
nnoremap('<leader>sd', telescope_b.diagnostics, { desc = '[s]earch [d]iagnostics' })
nnoremap("<leader>sf", function()
  telescope_b.find_files({ hidden = true })
end, { desc = "[s]earch [f]iles" })

nnoremap("<leader>sc", function()
  telescope_b.commands(require("telescope.themes").get_dropdown({
    previewer = false,
  }))
end, { desc = "[s]earch [c]ommands" })

nnoremap("<leader>/", function()
  telescope_b.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
    previewer = true,
    winblend = 10,
  }))
end, { desc = "[/] Fuzzily search in current buffer]" })

nnoremap("<leader>ss", function()
  telescope_b.spell_suggest(require("telescope.themes").get_dropdown({
    previewer = false,
  }))
end, { desc = "[s]earch [s]pelling suggestions" })

-- LSP keybindings
M.map_common_lsp_keybinds = function(buffer_number)
  nnoremap("<leader>rn", vim.lsp.buf.rename, { desc = "LSP: [r]e[n]ame", buffer = buffer_number })
  nnoremap("<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: [c]ode [a]ction", buffer = buffer_number })

  -- Telescope LSP keybinds
  nnoremap("<leader>bs", require("telescope.builtin").lsp_document_symbols,
    { desc = "LSP: [B]uffer [S]ymbols", buffer = buffer_number })
  nnoremap("<leader>ps", require("telescope.builtin").lsp_workspace_symbols,
    { desc = "LSP: [P]roject [S]ymbols", buffer = buffer_number })

  -- See `:help K` for why this keymap
  nnoremap("K", vim.lsp.buf.hover, { desc = "LSP: Hover Documentation", buffer = buffer_number })
  nnoremap("<leader>k", vim.lsp.buf.signature_help, { desc = "LSP: Signature Documentation", buffer = buffer_number })
  inoremap("<C-k>", vim.lsp.buf.signature_help, { desc = "LSP: Signature Documentation", buffer = buffer_number })

  -- Lesser used LSP functionality
  nnoremap("gD", vim.lsp.buf.declaration, { desc = "LSP: [g]oto [d]eclaration", buffer = buffer_number })
end

M.map_default_lsp_keybinds = function(buffer_number)
  M.map_common_lsp_keybinds(buffer_number)
  nnoremap("gd", vim.lsp.buf.definition, { desc = "LSP: [g]oto [d]efinition", buffer = buffer_number })
  nnoremap("gr", require("telescope.builtin").lsp_references,
    { desc = "LSP: [G]oto [R]eferences", buffer = buffer_number })
  nnoremap("gi", require("telescope.builtin").lsp_implementations,
    { desc = "LSP: [G]oto [I]mplementation", buffer = buffer_number })
  nnoremap("td", vim.lsp.buf.type_definition, { desc = "LSP: [t]ype [d]efinition", buffer = buffer_number })
end

M.map_omnisharp_keybinds = function(buffer_number)
  M.map_common_lsp_keybinds(buffer_number)
  nnoremap("gd", "<cmd>lua require('omnisharp_extended').lsp_definition()<cr>",
    { desc = "LSP: [g]oto [d]efinition", buffer = buffer_number })
  nnoremap("gr", "<cmd>lua require('omnisharp_extended').lsp_references()<cr>",
    { desc = "LSP: [G]oto [R]eferences", buffer = buffer_number })
  nnoremap("gi", "<cmd>lua require('omnisharp_extended').lsp_implementation()<cr>",
    { desc = "LSP: [G]oto [I]mplementation", buffer = buffer_number })
  nnoremap("<leader>D", "<cmd>lua require('omnisharp_extended').lsp_type_definition()<cr>",
    { desc = "LSP: [t]ype [d]efinition", buffer = buffer_number })
end

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

-- Insert --
-- Map jj to <esc>
inoremap("jj", "<esc>")

-- Visual --
-- Press 'H', 'L' to jump to start/end of a line (first/last char)
vnoremap("L", "$<left>", { desc = "Move to end of line and adjust cursor left" })
vnoremap("H", "^", { desc = "Move to beginning of line" })
vnoremap("<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down and reselect" })
vnoremap("<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up and reselect" })

-- Terminal --
-- Enter normal mode while in a terminal
tnoremap("<esc>", [[<C-\><C-n>]], { desc = "Terminal: Exit to normal mode" })
tnoremap("jj", [[<C-\><C-n>]], { desc = "Terminal: Exit to normal mode with jj" })
tnoremap('<C-q>', '<C-\\><C-n>', { desc = "Terminal: Quit terminal mode and enter normal mode" })
tnoremap('<A-t>', '<C-\\><C-n>:q<CR>', { desc = "Terminal: Quit the terminal window" })
tnoremap("<C-h>", [[<Cmd>wincmd h<CR>]], { desc = "Terminal: Navigate to left window" })
tnoremap("<C-j>", [[<Cmd>wincmd j<CR>]], { desc = "Terminal: Navigate to below window" })
tnoremap("<C-k>", [[<Cmd>wincmd k<CR>]], { desc = "Terminal: Navigate to above window" })
tnoremap("<C-l>", [[<Cmd>wincmd l<CR>]], { desc = "Terminal: Navigate to right window" })
tnoremap("<space>", "<space>", { desc = "Terminal: Reenable default space functionality" })

return M
