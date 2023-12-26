local function map(mode, keys, cmd, desc)
  vim.keymap.set(mode, keys, cmd, { desc = desc, silent = true })
end

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- general
map({ 'n', 'v' }, '<Space>', '<Nop>')
map({ 'n', 'v' }, '<leader>e', function()
  require('vscode-neovim').call('workbench.view.explorer')
end)


-- don't yank on delete and change
map({ 'n', 'v' }, 'd', '"_d')
map({ 'n', 'v' }, 'c', '"_c')
map({ 'n', 'v' }, 'x', '"_x')
map({ 'n', 'v' }, 's', '"_s')

-- navigation
map({ 'n', 'v', 'o' }, 'gll', '$')
map({ 'n', 'v', 'o' }, 'ghh', '^')
map({ 'n', 'v', 'o' }, '<C-j>', '5j')
map({ 'n', 'v', 'o' }, '<C-k>', '5k')

-- leader
map('n', '<leader>o', 'A,<esc>o')

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
