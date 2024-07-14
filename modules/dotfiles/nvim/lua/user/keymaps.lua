local nnoremap = require("user.keymaps-helper").nnoremap
local vnoremap = require("user.keymaps-helper").vnoremap
local inoremap = require("user.keymaps-helper").inoremap
local tnoremap = require("user.keymaps-helper").tnoremap
local xnoremap = require("user.keymaps-helper").xnoremap

local M = {}

local TERM = os.getenv("TERM")

-- Insert --
-- Map jj to <esc>
inoremap("jj", "<esc>")

-- Normal --
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

-- Visual --
vnoremap("<space>", "<nop>", { desc = "Disable Space bar" })
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

-- Plugins --

-- Git keymaps
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

nnoremap("<leader>ss", function()
  telescope_b.spell_suggest(require("telescope.themes").get_dropdown({
    previewer = false,
  }))
end, { desc = "[S]earch [s]pelling suggestions" })

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

-- Oil
M.oil = function()
  return {
    ["g?"] = "actions.show_help",
    ["<CR>"] = "actions.select",
    ["<C-\\>"] = "actions.select_split",
    ["<C-enter>"] = "actions.select_vsplit",
    ["<C-t>"] = "actions.select_tab",
    ["<C-p>"] = "actions.preview",
    ["<C-c>"] = "actions.close",
    ["<C-r>"] = "actions.refresh",
    ["-"] = "actions.parent",
    ["_"] = "actions.open_cwd",
    ["`"] = "actions.cd",
    ["~"] = "actions.tcd",
    ["gs"] = "actions.change_sort",
    ["gx"] = "actions.open_external",
    ["g."] = "actions.toggle_hidden",
  }
end

-- Harpoon
M.harpoon = function(harpoon)
  nnoremap("<leader>ha", function() harpoon:list():append() end, { desc = 'Add mark' })
  nnoremap("<leader>hd", function() harpoon:list():remove() end, { desc = 'Remove mark' })

  nnoremap("<leader>h1", function() harpoon:list():select(1) end, { desc = 'Go to 1' })
  nnoremap("<leader>h2", function() harpoon:list():select(2) end, { desc = 'Go to 2' })
  nnoremap("<leader>h3", function() harpoon:list():select(3) end, { desc = 'Go to 3' })
  nnoremap("<leader>h4", function() harpoon:list():select(4) end, { desc = 'Go to 4' })

  nnoremap("<C-S-P>", function() harpoon:list():prev() end)
  nnoremap("<C-S-N>", function() harpoon:list():next() end)

  local conf = require("telescope.config").values
  local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
      table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
      prompt_title = "Harpoon",
      finder = require("telescope.finders").new_table({
        results = file_paths,
      }),
      previewer = conf.file_previewer({}),
      sorter = conf.generic_sorter({}),
    }):find()
  end

  nnoremap("<C-e>", function() toggle_telescope(harpoon:list()) end, { desc = "Open harpoon window" })
end

-- AI
inoremap("<C-CR>", function()
  return vim.fn["codeium#Accept"]()
end, { expr = true, silent = true, desc = "AI chat accept" })

nnoremap("<leader>a", function()
  return vim.fn["codeium#Chat"]()
end, { expr = true, silent = true, desc = " AI chat" })

-- Navigation
nnoremap('<leader>e', ':Neotree toggle<CR>', { desc = 'Toggle file tree [e]explorer' })
nnoremap("<leader>oi", function()
  require("oil").toggle_float()
end, { desc = "[O]il [f]ile managment" })

-- LSP
M.common_lsp = function(buffer_number)
  nnoremap("<leader>rn", vim.lsp.buf.rename, { desc = "LSP: [R]e[n]ame", buffer = buffer_number })
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
    { "<leader>c",        group = "Code" },
    { "<leader>so",       group = "Search [O]bsidian notes" },
    { "<leader>d",        group = "Diagnostic" },
    { "<leader>g",        group = "Git" },
    { "<leader>gt",       group = "Git [T]oggles" },
    { "<leader>h",        group = "Harpoon" },
    { "<leader>r",        group = "Rename" },
    { "<leader>s",        group = "Search" },
    { "<leader>o",        group = "Obsidian and oil" },
    { "<leader>l",        group = "Lazy git" },
    -- hidden
    { "<leader>q",        hidden = true },
    { "<leader>f",        hidden = true },
    { "<leader><leader>", hidden = true },
    { "<leader>w",        hidden = true },
    { "<leader>z",        hidden = true },

  })
end

-- Gitsigns
M.gitsigns = function(gs, bufnr)
  local function map(mode, l, r, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, l, r, opts)
  end

  -- Navigation
  map({ 'n', 'v' }, ']c', function()
    if vim.wo.diff then
      return ']c'
    end
    vim.schedule(function()
      gs.next_hunk()
    end)
    return '<Ignore>'
  end, { expr = true, desc = 'Jump to next hunk' })

  map({ 'n', 'v' }, '[c', function()
    if vim.wo.diff then
      return '[c'
    end
    vim.schedule(function()
      gs.prev_hunk()
    end)
    return '<Ignore>'
  end, { expr = true, desc = 'Jump to previous hunk' })

  -- Actions
  vnoremap('<leader>gs', function()
    gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
  end, { desc = 'Stage git hunk' })
  vnoremap('<leader>gr', function()
    gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
  end, { desc = 'Reset git hunk' })

  nnoremap('<leader>gs', gs.stage_hunk, { desc = 'Git stage hunk' })
  nnoremap('<leader>gr', gs.reset_hunk, { desc = 'Git reset hunk' })
  nnoremap('<leader>gS', gs.stage_buffer, { desc = 'Git Stage buffer' })
  nnoremap('<leader>gu', gs.undo_stage_hunk, { desc = 'Undo stage hunk' })
  nnoremap('<leader>gR', gs.reset_buffer, { desc = 'Git Reset buffer' })
  nnoremap('<leader>gp', gs.preview_hunk, { desc = 'Preview git hunk' })
  nnoremap('<leader>gb', function()
    gs.blame_line { full = false }
  end, { desc = 'Git blame line' })
  nnoremap('<leader>gd', gs.diffthis, { desc = 'Git diff against index' })
  nnoremap('<leader>gD', function()
    gs.diffthis '~'
  end, { desc = 'Git diff against last commit' })

  -- Toggles
  nnoremap('<leader>gtb', gs.toggle_current_line_blame, { desc = 'Toggle git blame line' })
  nnoremap('<leader>gtd', gs.toggle_deleted, { desc = 'Toggle git show deleted' })

  -- Text object
  map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'Select git hunk' })
end

-- Lazygit
nnoremap("<leader>lg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })

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
