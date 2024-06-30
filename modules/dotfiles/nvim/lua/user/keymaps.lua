local nnoremap = require("user.keymaps-helper").nnoremap
local vnoremap = require("user.keymaps-helper").vnoremap
local inoremap = require("user.keymaps-helper").inoremap
local tnoremap = require("user.keymaps-helper").tnoremap
local xnoremap = require("user.keymaps-helper").xnoremap

local M = {}

local TERM = os.getenv("TERM")

-- Disable Space bar since it'll be used as the leader key
nnoremap("<space>", "<nop>")
vnoremap("<space>", "<nop>")

--------.
-- Normal
---------

-- Press 'U' for redo
nnoremap("U", "<C-r>")
-- Save with leader key
nnoremap("<leader>w", "<cmd>w<cr>", { silent = false })
-- Quit with leader key
nnoremap("<leader>q", "<cmd>q<cr>", { silent = false })
-- Save and Quit with leader key
nnoremap("<leader>z", "<cmd>wq<cr>", { silent = false })

-- New
-- vim.api.nvim_set_keymap('n', '<leader>sr', ':%s/<C-R><C-W>//g<Left><Left>', { noremap = true, silent = true, desc = 'Substitute word under cursor globally' })
vim.keymap.set("n", "<leader>on", function()
  vim.cmd("ObsidianTemplate note")
  vim.cmd("1,/^\\S/s/^\\n\\{1,}//e")
end, { desc = '[O]bsidian [n]ote' })

-- Navigation
nnoremap('<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle file tree [e]explorer' })
nnoremap("<leader>oi", function()
  require("oil").toggle_float()
end, { desc = "[O]il [f]ile managment" })

nnoremap('k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
nnoremap('j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- Center buffer while navigating
nnoremap("<C-u>", "<C-u>zz")
nnoremap("<C-d>", "<C-d>zz")
nnoremap("{", "{zz")
nnoremap("}", "}zz")
nnoremap("N", "Nzz")
nnoremap("n", "nzz")
nnoremap("G", "Gzz")
nnoremap("gg", "ggzz")
nnoremap("<C-i>", "<C-i>zz")
nnoremap("<C-o>", "<C-o>zz")
-- Find stuff (:noh clears). Need better keymap for this
nnoremap("%", "%zz")
nnoremap("*", "*zz")
nnoremap("#", "#zz")

-- Press 'S' for quick find/replace for the word under the cursor
nnoremap("S", function()
  local cmd = ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>"
  local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
  vim.api.nvim_feedkeys(keys, "n", false)
end)

-- Press 'H', 'L' to jump to start/end of a line (first/last char)
nnoremap("L", "$")
nnoremap("H", "^")

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

-- LSP Keybinds (exports a function to be used in ../../after/plugin/lsp.lua b/c we need a reference to the current buffer) --
M.map_lsp_keybinds = function(buffer_number)
  nnoremap("<leader>rn", vim.lsp.buf.rename, { desc = "LSP: [r]e[n]ame", buffer = buffer_number })
  nnoremap("<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: [c]ode [a]ction", buffer = buffer_number })

  nnoremap("gd", vim.lsp.buf.definition, { desc = "LSP: [g]oto [d]efinition", buffer = buffer_number })

  -- Telescope LSP keybinds --
  nnoremap(
    "gr",
    require("telescope.builtin").lsp_references,
    { desc = "LSP: [G]oto [R]eferences", buffer = buffer_number }
  )

  nnoremap(
    "gi",
    require("telescope.builtin").lsp_implementations,
    { desc = "LSP: [G]oto [I]mplementation", buffer = buffer_number }
  )

  nnoremap(
    "<leader>bs",
    require("telescope.builtin").lsp_document_symbols,
    { desc = "LSP: [B]uffer [S]ymbols", buffer = buffer_number }
  )

  nnoremap(
    "<leader>ps",
    require("telescope.builtin").lsp_workspace_symbols,
    { desc = "LSP: [P]roject [S]ymbols", buffer = buffer_number }
  )

  -- See `:help K` for why this keymap
  nnoremap("K", vim.lsp.buf.hover, { desc = "LSP: Hover Documentation", buffer = buffer_number })
  nnoremap("<leader>k", vim.lsp.buf.signature_help, { desc = "LSP: Signature Documentation", buffer = buffer_number })
  inoremap("<C-k>", vim.lsp.buf.signature_help, { desc = "LSP: Signature Documentation", buffer = buffer_number })

  -- Lesser used LSP functionality
  nnoremap("gD", vim.lsp.buf.declaration, { desc = "LSP: [g]oto [d]eclaration", buffer = buffer_number })
  nnoremap("td", vim.lsp.buf.type_definition, { desc = "LSP: [t]ype [d]efinition", buffer = buffer_number })
end


-- Insert --
-- Map jj to <esc>
inoremap("jj", "<esc>")

-- Visual --
-- Press 'H', 'L' to jump to start/end of a line (first/last char)
vnoremap("L", "$<left>")
vnoremap("H", "^")

-- Paste without losing the contents of the register
vnoremap("<A-j>", ":m '>+1<CR>gv=gv")
vnoremap("<A-k>", ":m '<-2<CR>gv=gv")

-- Reselect the last visual selection
xnoremap("<<", function()
  xnoremap("<leader>p", '"_dP')

  -- Move selected text up/down in visual mode
  vim.cmd("normal! <<")
  vim.cmd("normal! gv")
end)

xnoremap(">>", function()
  vim.cmd("normal! >>")
  vim.cmd("normal! gv")
end)

-- Terminal --
-- Enter normal mode while in a terminal
tnoremap("<esc>", [[<C-\><C-n>]])
tnoremap("jj", [[<C-\><C-n>]])
-- quit Terminal mode, but leave the terminal window open and go to normal mode
tnoremap('<C-q>', '<C-\\><C-n>')
-- quit the terminal window
tnoremap('<A-t>', '<C-\\><C-n>:q<CR>') -- Better wripe line navigation
-- Window navigation from terminal
tnoremap("<C-h>", [[<Cmd>wincmd h<CR>]])
tnoremap("<C-j>", [[<Cmd>wincmd j<CR>]])
tnoremap("<C-k>", [[<Cmd>wincmd k<CR>]])
tnoremap("<C-l>", [[<Cmd>wincmd l<CR>]])

-- Reenable default <space> functionality to prevent input delay
tnoremap("<space>", "<space>")

return M
