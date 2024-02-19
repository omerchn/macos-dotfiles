return {
  {
    'mrjones2014/smart-splits.nvim',
    config = function()
      require('smart-splits').setup({
        at_edge = 'wrap',
      })

      local SmartSplits = require('smart-splits')

      -- resizing splits
      vim.keymap.set('n', '<A-h>', function()
        SmartSplits.resize_left(10)
      end)
      vim.keymap.set('n', '<A-j>', SmartSplits.resize_down)
      vim.keymap.set('n', '<A-k>', SmartSplits.resize_up)
      vim.keymap.set('n', '<A-l>', function()
        SmartSplits.resize_right(10)
      end)

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
    end,
  },
}
