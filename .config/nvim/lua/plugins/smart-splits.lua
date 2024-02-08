return {
  {
    'mrjones2014/smart-splits.nvim',
    config = function()
      require('smart-splits').setup({
        at_edge = 'wrap',
      })

      local SmartSplits = require('smart-splits')

      -- recommended mappings
      -- resizing splits
      -- these keymaps will also accept a range,
      -- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
      vim.keymap.set('n', '<A-h>', SmartSplits.resize_left)
      vim.keymap.set('n', '<A-j>', SmartSplits.resize_down)
      vim.keymap.set('n', '<A-k>', SmartSplits.resize_up)
      vim.keymap.set('n', '<A-l>', SmartSplits.resize_right)
      -- moving between splits
      vim.keymap.set('n', '<C-h>', SmartSplits.move_cursor_left)
      vim.keymap.set('n', '<C-j>', SmartSplits.move_cursor_down)
      vim.keymap.set('n', '<C-k>', SmartSplits.move_cursor_up)
      vim.keymap.set('n', '<C-l>', SmartSplits.move_cursor_right)
      -- swapping buffers between windows
      vim.keymap.set('n', '<leader><leader>h', function()
        SmartSplits.swap_buf_left({ move_cursor = true })
      end)
      vim.keymap.set('n', '<leader><leader>j', function()
        SmartSplits.swap_buf_down({ move_cursor = true })
      end)
      vim.keymap.set('n', '<leader><leader>k', function()
        SmartSplits.swap_buf_up({ move_cursor = true })
      end)
      vim.keymap.set('n', '<leader><leader>l', function()
        SmartSplits.swap_buf_right({ move_cursor = true })
      end)
      --

      for i = 1, 9 do
        vim.keymap.set({ 'n', 'x', 'o' }, '<leader>t' .. i, ':ToggleTerm ' .. i .. '<cr>',
          { desc = 'ToggleTerm - to terminal ' .. i })
      end
    end,
  },
}
