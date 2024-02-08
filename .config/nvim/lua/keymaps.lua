local function map(mode, keys, cmd, desc)
  vim.keymap.set(mode, keys, cmd, { desc = desc, silent = true })
end

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- general
map({ 'n', 'v' }, '<Space>', '<Nop>')
map({ 'n' }, '<Esc>', '<Esc>:noh<CR>')

-- don't yank on delete, change and paste over
map({ 'n', 'v' }, 'd', '"_d')
map({ 'n', 'v' }, 'c', '"_c')
map({ 'n', 'v' }, 'D', '"_D')
map({ 'n', 'v' }, 'C', '"_C')
map('v', 'p', '"_dP')

-- navigation
map({ 'n', 'v', 'o' }, '<C-d>', '<C-d>zz')
map({ 'n', 'v', 'o' }, '<C-u>', '<C-u>zz')

-- move lines
map('v', '<M-j>', ":m '>+1<CR>gv=gv")
map('v', '<M-k>', ":m '<-2<CR>gv=gv")
map('v', '<M-Down>', ":m '>+1<CR>gv=gv")
map('v', '<M-Up>', ":m '<-2<CR>gv=gv")

-- splits
-- map({ 'n', 'v' }, '<M-C-l>', ':vertical split<cr><C-w>l')
-- map({ 'n', 'v' }, '<M-C-h>', ':vertical split<cr>')
-- map({ 'n', 'v' }, '<M-C-j>', ':split<cr><C-w>j')
-- map({ 'n', 'v' }, '<M-C-k>', ':split<cr>')
-- map({ 'n', 'v' }, '<M-C-Right>', ':vertical split<cr><C-w>l')
-- map({ 'n', 'v' }, '<M-C-Left>', ':vertical split<cr>')
-- map({ 'n', 'v' }, '<M-C-Down>', ':split<cr><C-w>j')
-- map({ 'n', 'v' }, '<M-C-Up>', ':split<cr>')

-- save, exit, format
map('n', '<leader>w', ':silent w<CR>', 'W]ite the file')
map('n', '<leader>q', ':q<CR>', 'Quit the file')
map('n', '<leader>b', ':qa<CR>', 'Quit all')
map('n', '<leader>x', ':x<CR>', 'Quit and save')
map('n', '<leader>f', ':Format<CR>:lua vim.diagnostic.enable()<CR>', 'Format file')

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

-- LSP
return {
  add_lsp_keymaps = function(bufnr)
    local nmap = function(keys, func, desc)
      if desc then
        desc = 'LSP: ' .. desc
      end

      vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>r', vim.lsp.buf.rename, '[R]ename')
    nmap('<leader>c', vim.lsp.buf.code_action, '[C]ode Action')

    -- re-defind in lua.plugins.trouble
    --
    -- nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    -- nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    -- nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    -- nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    -- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    -- nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  end,
}