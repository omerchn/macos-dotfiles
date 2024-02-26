local function map(mode, keys, cmd, desc)
  vim.keymap.set(mode, keys, cmd, { desc = desc, silent = true })
end

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- general
map({ 'n', 'v' }, '<Space>', '<Nop>')
map({ 'n' }, '<Esc>', '<Esc>:noh<CR>')

-- movement
-- map({ 'n', 'v' }, '<C-j>', '5j')
-- map({ 'n', 'v' }, '<C-k>', '5k')

-- don't yank on delete, change and paste over
map({ 'n', 'v' }, 'd', '"_d')
map({ 'n', 'v' }, 'c', '"_c')
map({ 'n', 'v' }, 'D', '"_D')
map({ 'n', 'v' }, 'C', '"_C')
map({ 'n', 'v' }, 's', '"_s')
map('n', 'x', '"_x')
map('v', 'p', '"_dP')

-- move lines
map('v', '<M-j>', ":m '>+1<CR>gv=gv")
map('v', '<M-k>', ":m '<-2<CR>gv=gv")

-- don't leave 'visual after indent
map('v', '>', '>gv')
map('v', '<', '<gv')

-- save, exit, format
map('n', '<leader>w', ':silent w<CR>', 'Write buffer')
map('n', '<C-c>', ':q<CR>', 'Close window')
map('n', '<leader>x', ':x<CR>', 'Close window and save buffer')
map('n', '<leader>f', ':Format<CR>:lua vim.diagnostic.enable()<CR>', 'Format buffer')

-- diagnostics
map('n', '<leader>dk', function()
  vim.diagnostic.goto_prev({ float = { source = true } })
end, 'Go to previous diagnostic message')
map('n', '<leader>dj', function()
  vim.diagnostic.goto_next({ float = { source = true } })
end, 'Go to next diagnostic message')
map('n', '<leader>de', function()
  vim.diagnostic.open_float({ source = true })
end, 'Open floating diagnostic message')

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
