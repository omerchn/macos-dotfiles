return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable('make') == 1
        end,
      },
      {
        'LukasPietzschmann/telescope-tabs',
        config = function()
          require('telescope').load_extension('telescope-tabs')
          require('telescope-tabs').setup()
        end,
        dependencies = { 'nvim-telescope/telescope.nvim' },
      },
    },
    config = function()
      local trouble = require('trouble.providers.telescope')
      local get_ivy = require('utils.telescope').get_ivy

      require('telescope').setup({
        pickers = {
          find_files = { hidden = true },
          oldfiles = { only_cwd = true, initial_mode = 'normal', prompt_prefix = '' },
          git_status = { initial_mode = 'normal', prompt_prefix = '' },
          grep_string = { initial_mode = 'normal', prompt_prefix = '' },
          buffers = {
            initial_mode = 'normal',
            prompt_prefix = '',
            mappings = {
              n = {
                ['<c-x>'] = require('telescope.actions').delete_buffer,
              },
              i = {
                ['<c-x>'] = require('telescope.actions').delete_buffer,
              },
            },
          },
        },
        defaults = get_ivy({
          mappings = {
            n = {
              ['<c-t>'] = trouble.open_with_trouble,
            },
            i = {
              ['<c-t>'] = trouble.open_with_trouble,
            },
          },
          file_ignore_patterns = { 'node_modules', '.git/' },
        }),
      })

      pcall(require('telescope').load_extension, 'fzf')

      vim.keymap.set('n', '<leader>/', function()
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
          layout_config = { mirror = true },
        }))
      end, { desc = '[/] Fuzzily search in current buffer' })

      vim.keymap.set('n', '<leader>so', function()
        require('telescope.builtin').oldfiles()
      end, { desc = 'Find recently [O]pened files' })

      vim.keymap.set('n', '<leader>ss', function()
        require('telescope.builtin').git_status()
      end, { desc = '[S]earch Git [S]tatus' })

      vim.keymap.set('n', '<leader>sf', function()
        require('telescope.builtin').find_files()
      end, { desc = '[S]earch [F]iles' })

      vim.keymap.set('n', '<leader>sh', function()
        require('telescope.builtin').help_tags()
      end, { desc = '[S]earch [H]elp' })

      vim.keymap.set('n', '<leader>sw', function()
        require('telescope.builtin').grep_string()
      end, { desc = '[S]earch current [W]ord' })

      vim.keymap.set('n', '<leader>sg', function()
        require('telescope.builtin').live_grep()
      end, { desc = '[S]earch by [G]rep' })

      vim.keymap.set('n', '<leader>sd', function()
        require('telescope.builtin').lsp_document_symbols()
      end, { desc = '[S]earch [D]ocument Symbols' })

      vim.keymap.set('n', '<leader>sr', function()
        require('telescope.builtin').resume()
      end, { desc = '[S]earch [R]esume' })

      vim.keymap.set('n', '<leader>sc', function()
        require('telescope.builtin').command_history()
      end, { desc = '[S]earch [C]ommand History' })

      vim.keymap.set('n', '<leader>sC', function()
        require('telescope.builtin').commands()
      end, { desc = '[S]earch [C]ommands' })

      vim.keymap.set('n', '<leader>b', function()
        require('telescope.builtin').buffers()
      end, { desc = '[S]earch [B]uffers' })
    end,
  },
  {
    'nvim-telescope/telescope-ui-select.nvim',
    config = function()
      require('telescope').setup({
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown({
              initial_mode = 'normal',
              prompt_prefix = '',
            }),
          },
        },
      })
      require('telescope').load_extension('ui-select')
    end,
  },
}
