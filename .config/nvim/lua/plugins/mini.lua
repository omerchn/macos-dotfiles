return {
  {
    'echasnovski/mini.files',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('mini.files').setup({
        mappings = {
          close = '<esc>',
        },
        options = {
          use_as_default_explorer = false,
        },
      })

      vim.keymap.set('n', '<leader>M', function()
        MiniFiles.open(vim.api.nvim_buf_get_name(0))
      end, { silent = true, desc = '[E]xplore' })

      local map_split = function(buf_id, lhs, direction)
        local rhs = function()
          local target_window = MiniFiles.get_target_window()
          if not target_window then
            return
          end
          -- Make new window and set it as target
          local new_target_window
          vim.api.nvim_win_call(target_window, function()
            vim.cmd(direction .. ' split')
            new_target_window = vim.api.nvim_get_current_win()
          end)

          MiniFiles.set_target_window(new_target_window)

          local key = vim.api.nvim_replace_termcodes('L', true, false, true)
          vim.api.nvim_feedkeys(key, 'm', false)
        end

        -- Adding `desc` will result into `show_help` entries
        local desc = 'Split ' .. direction
        vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
      end

      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesBufferCreate',
        callback = function(args)
          local buf_id = args.data.buf_id
          -- Tweak keys to your liking
          map_split(buf_id, '<C-s>', 'belowright horizontal')
          map_split(buf_id, '<C-v>', 'belowright vertical')
        end,
      })
    end,
  },

  {
    'echasnovski/mini.operators',
    version = '*',
    config = function()
      require('mini.operators').setup({
        replace = {
          prefix = 'gp',
        },
      })
    end,
  },
}
