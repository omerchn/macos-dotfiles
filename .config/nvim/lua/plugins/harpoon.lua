return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require('harpoon')
      harpoon:setup({})

      vim.keymap.set({ 'n', 'x', 'o' }, '<leader>ha', function()
        harpoon:list():append()
        print('Added mark')
      end, { desc = 'Harpoon - Toggle Mark' })

      vim.keymap.set({ 'n', 'x', 'o' }, '<leader>hr', function()
        harpoon:list():remove()
        print('Removed mark')
      end, { desc = 'Harpoon - Toggle Mark' })

      vim.keymap.set({ 'n', 'x', 'o' }, '<leader>hl', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = 'Harpoon - List' })

      for i = 1, 9 do
        vim.keymap.set({ 'n', 'x', 'o' }, '<C-' .. i .. '>', function()
          harpoon:list():select(i)
        end, { desc = 'Harpoon - to file ' .. i })
      end
    end,
  },
}
