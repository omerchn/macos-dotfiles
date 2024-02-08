return {
  'ThePrimeagen/harpoon',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    vim.keymap.set({ 'n', 'x', 'o' }, '<leader>m', require('harpoon.mark').toggle_file,
      { desc = 'Harpoon - Toggle Mark' })

    vim.keymap.set({ 'n', 'x', 'o' }, '<leader>j', require('harpoon.ui').toggle_quick_menu, { desc = 'Harpoon - List' })

    vim.keymap.set('n', '<leader>sj', '<cmd>:Telescope harpoon marks<cr>', { desc = '[S]earch [H]arpoon' })

    for i = 1, 9 do
      vim.keymap.set({ 'n', 'x', 'o' }, '<C-' .. i .. '>', function()
        require('harpoon.ui').nav_file(i)
      end, { desc = 'Harpoon - to file ' .. i })
    end

    pcall(require('telescope').load_extension, 'harpoon')
  end,
}
