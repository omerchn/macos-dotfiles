return {
  'ThePrimeagen/harpoon',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('harpoon').setup({
      tabline = false,
    })

    vim.keymap.set({ 'n', 'x', 'o' }, '<C-m>', require('harpoon.mark').toggle_file, { desc = 'Harpoon - Toggle Mark' })

    vim.keymap.set({ 'n', 'x', 'o' }, '<leader>h', require('harpoon.ui').toggle_quick_menu, { desc = 'Harpoon - List' })

    vim.keymap.set('n', '<leader>sl', function()
      require('telescope').extensions.harpoon.marks(require('utils.telescope').get_ivy({
        prompt_title = '󰛢 Harpoon Marks',
      }))
    end, { desc = '[S]earch Harpoon Marks [L]ist' })

    for i = 1, 9 do
      vim.keymap.set({ 'n', 'x', 'o' }, '<C-' .. i .. '>', function()
        require('harpoon.ui').nav_file(i)
      end, { desc = 'Harpoon - to file ' .. i })
    end

    pcall(require('telescope').load_extension, 'harpoon')
  end,
}
