return {
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'sindrets/diffview.nvim',
        config = function()
          local diffview = require('diffview')
          diffview.setup({
            keymaps = {
              view = {
                ['q'] = ':tabclose<CR>',
              },
              file_panel = {
                ['q'] = ':tabclose<CR>',
              },
            },
          })
          vim.opt.fillchars:append({ diff = '╱' })
          vim.keymap.set({ 'n' }, '<leader>gd', function()
            diffview.open({})
          end, { desc = 'Open Diffview' })
        end,
      },
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      local neogit = require('neogit')
      neogit.setup({})
      vim.keymap.set({ 'n' }, '<leader>gg', function()
        neogit.open({ kind = 'auto' })
      end, { desc = 'Open Neogit' })
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      current_line_blame = true,
      attach_to_untracked = true,
      current_line_blame_opts = { delay = 200 },
      on_attach = function(bufnr)
        local gs = require('gitsigns')
        vim.keymap.set({ 'n', 'v' }, '<leader>gj', gs.next_hunk, { buffer = bufnr, desc = 'Next Hunk' })
        vim.keymap.set({ 'n', 'v' }, '<leader>gk', gs.prev_hunk, { buffer = bufnr, desc = 'Previous Hunk' })
        vim.keymap.set('n', '<leader>gp', gs.preview_hunk_inline, { buffer = bufnr, desc = 'Preview Hunk inline' })
        vim.keymap.set('n', '<leader>gr', gs.reset_hunk, { buffer = bufnr, desc = 'Reset Hunk' })
        vim.keymap.set('v', '<leader>gr', ':Gitsigns reset_hunk<cr>', { buffer = bufnr, desc = 'Reset Hunk' })
        vim.keymap.set('n', '<leader>gR', gs.reset_buffer, { buffer = bufnr, desc = 'Reset Buffer' })
      end,
    },
  },
}
