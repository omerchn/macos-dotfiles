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
          use_as_default_explorer = true,
        },
        windows = {
          preview = true,
          width_preview = 50,
        },
      })

      vim.keymap.set('n', '<leader>m', function()
        MiniFiles.open(vim.api.nvim_buf_get_name(0))
        -- MiniFiles.reveal_cwd()
      end, { silent = true, desc = '[M]ini Files' })

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
          -- split maps
          map_split(buf_id, '<C-x>', 'horizontal')
          map_split(buf_id, '<C-v>', 'vertical')
          -- navigation
          local function forward()
            local key = vim.api.nvim_replace_termcodes('L', true, false, true)
            vim.api.nvim_feedkeys(key, 'm', false)
          end
          local function backward()
            local key = vim.api.nvim_replace_termcodes('h', true, false, true)
            vim.api.nvim_feedkeys(key, 'm', false)
          end
          vim.keymap.set('n', 'l', forward, { buffer = buf_id })
          vim.keymap.set('n', '<enter>', forward, { buffer = buf_id })
          vim.keymap.set('n', '<right>', forward, { buffer = buf_id })
          vim.keymap.set('n', '<left>', backward, { buffer = buf_id })
        end,
      })
    end,
  },

  {
    'echasnovski/mini.operators',
    version = '*',
    config = function()
      require('mini.operators').setup({
        multiply = {
          prefix = 'gm',
        },
        evaluate = {
          prefix = '',
        },
        exchange = {
          prefix = 'gx',
        },
        replace = {
          prefix = '',
        },
        sort = {
          prefix = '',
        },
      })
    end,
  },
}
