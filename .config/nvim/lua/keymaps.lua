local function map(mode, keys, cmd, desc)
  vim.keymap.set(mode, keys, cmd, { desc = desc, silent = true })
end

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- general
map({ 'n', 'v' }, '<Space>', '<Nop>')
map({ 'n' }, '<Esc>', '<Esc>:noh<CR>')
map({ 'n' }, '<C-j>', '<C-w>j')
map({ 'n' }, '<C-k>', '<C-w>k')
map({ 'n' }, '<C-h>', '<C-w>h')
map({ 'n' }, '<C-l>', '<C-w>l')

-- don't yank on delete, change and paste over
map({ 'n', 'v' }, 'd', '"_d')
map({ 'n', 'v' }, 'c', '"_c')
map({ 'n', 'v' }, 'D', '"_D')
map({ 'n', 'v' }, 'C', '"_C')
map({ 'n', 'v' }, 'p', '"_dP')

-- navigation
map({ 'n', 'v', 'o' }, '<C-j>', '5j')
map({ 'n', 'v', 'o' }, '<C-k>', '5k')

-- move lines
map('v', '<M-C-j>', ":m '>+1<CR>gv=gv")
map('v', '<M-C-k>', ":m '<-2<CR>gv=gv")

-- save, exit, format
map('n', '<leader>w', ':silent w<CR>', '[W]rite the file')
map('n', '<leader>q', ':q<CR>', '[Q]uit the file')
map('n', '<leader>x', ':x<CR>', '[X]it - Quit and save')
map('n', '<leader>f', ':Format<CR>:lua vim.diagnostic.enable()<CR>', '[F]ormat file')

-- buffers
-- map('n', '<leader>bd', ':bd<CR>', '[B]uffer [D]elete')
-- map('n', '<leader>l', ':bnext<CR>', 'Next buffer')
-- map('n', '<leader>h', ':bprevious<CR>', 'Previous buffer')
-- map('n', '<leader>bl', ':blast<CR>', 'Last buffer')
-- map('n', '<leader>bh', ':bfirst<CR>', 'First buffer')

-- Diagnostics
map('n', '[d', vim.diagnostic.goto_prev, 'Go to previous diagnostic message')
map('n', ']d', vim.diagnostic.goto_next, 'Go to next diagnostic message')
map('n', '<leader>de', vim.diagnostic.open_float, 'Open floating diagnostic message')
map('n', '<leader>dl', vim.diagnostic.setloclist, 'Open diagnostics list')

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- LSP
return {
  add_lsp_keymaps = function(bufnr)
    local nmap = function(keys, func, desc)
      if desc then
        desc = 'LSP: ' .. desc
      end

      vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    -- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  end,
}
