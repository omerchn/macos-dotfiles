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
          find_files = {
            hidden = true,
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

      vim.keymap.set('n', '<leader>?', function()
        require('telescope.builtin').oldfiles({ only_cwd = true, initial_mode = 'normal', prompt_prefix = '' })
      end, { desc = '[?] Find recently opened files' })

      vim.keymap.set('n', '<leader>/', function()
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown())
      end, { desc = '[/] Fuzzily search in current buffer' })

      vim.keymap.set('n', '<leader>ss', function()
        require('telescope.builtin').git_status({ initial_mode = 'normal', prompt_prefix = '' })
      end, { desc = '[S]earch Git [S]tatus' })

      vim.keymap.set('n', '<leader>sf', function()
        require('telescope.builtin').find_files()
      end, { desc = '[S]earch [F]iles' })

      vim.keymap.set('n', '<leader>sh', function()
        require('telescope.builtin').help_tags()
      end, { desc = '[S]earch [H]elp' })

      vim.keymap.set('n', '<leader>sw', function()
        require('telescope.builtin').grep_string({ initial_mode = 'normal', prompt_prefix = '' })
      end, { desc = '[S]earch current [W]ord' })

      vim.keymap.set('n', '<leader>sg', function()
        require('telescope.builtin').live_grep()
      end, { desc = '[S]earch by [G]rep' })

      vim.keymap.set('n', '<leader>sd', function()
        require('telescope.builtin').diagnostics({ initial_mode = 'normal', prompt_prefix = '' })
      end, { desc = '[S]earch [D]iagnostics' })

      vim.keymap.set('n', '<leader>ds', function()
        require('telescope.builtin').lsp_document_symbols()
      end, { desc = '[D]ocument [S]ymbols' })

      -- vim.keymap.set({ 'n' }, '<leader>st', function()
      --   require('telescope-tabs').list_tabs(get_ivy({ initial_mode = 'normal', prompt_prefix = '' }))
      -- end, { desc = '[S]earch [T]abs' })
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
