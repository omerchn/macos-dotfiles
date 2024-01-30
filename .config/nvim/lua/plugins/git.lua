return {
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      local neogit = require('neogit')

      neogit.setup({})

      vim.keymap.set({ 'n' }, '<leader>gg', function()
        neogit.open({ kind = 'auto' })
      end, { desc = 'Open Neogit' })

      vim.keymap.set({ 'n' }, '<leader>gc', function()
        neogit.open({ 'commit' })
      end, { desc = 'Neogit commit' })
    end
  },
}
