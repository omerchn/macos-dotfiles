return {
  'ThePrimeagen/harpoon',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    -- vim.keymap.set({ 'n', 'x', 'o' }, '<leader>hs', function()
    --   require('harpoon.mark').add_file()
    --   print('Mark added')
    -- end, { desc = 'Harpoon - Set Mark' })

    vim.keymap.set({ 'n', 'x', 'o' }, '<leader>hh', require('harpoon.mark').toggle_file,
      { desc = 'Harpoon - Toggle Mark' })

    vim.keymap.set({ 'n', 'x', 'o' }, '<leader>hl', require('harpoon.ui').toggle_quick_menu, { desc = 'Harpoon - List' })

    vim.keymap.set('n', '<leader>ht', '<cmd>:Telescope harpoon marks<cr>', { desc = 'Harpoon - Telescope' })

    for i = 1, 9 do
      vim.keymap.set({ 'n', 'x', 'o' }, '<C-' .. i .. '>', function()
        require('harpoon.ui').nav_file(i)
      end, { desc = 'Harpoon - to file ' .. i })
    end
  end
}
