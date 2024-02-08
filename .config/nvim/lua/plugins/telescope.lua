return {
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
    require('telescope').setup({
      pickers = {
        find_files = {
          hidden = true,
        },
      },
      defaults = {
        mappings = {
          n = {
            ['<c-t>'] = trouble.open_with_trouble,
          },
          i = {
            ['<C-u>'] = false,
            ['<C-d>'] = false,
            ['<c-t>'] = trouble.open_with_trouble,
          },
        },
        file_ignore_patterns = { 'node_modules', '.git/' },
        sorting_strategy = 'ascending',
        layout_strategy = 'horizontal',
        layout_config = {
          horizontal = {
            prompt_position = 'top',
            mirror = true,
            preview_width = 0.4,
          },
          vertical = {
            mirror = true,
            prompt_position = 'top',
          },
          center = {
            mirror = true,
          },
        },
      },
    })

    pcall(require('telescope').load_extension, 'fzf')

    vim.keymap.set('n', '<leader>?', function()
      require('telescope.builtin').oldfiles({ only_cwd = true })
    end, { desc = '[?] Find recently opened files' })

    vim.keymap.set('n', '<leader>/', function()
      require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown())
    end, { desc = '[/] Fuzzily search in current buffer' })

    vim.keymap.set('n', '<leader>ss', function()
      require('telescope.builtin').git_status({ initial_mode = 'normal' })
    end, { desc = '[S]earch Git [S]tatus' })
    vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols,
      { desc = '[D]ocument [S]ymbols' })
    vim.keymap.set({ 'n' }, '<leader>st', require('telescope-tabs').list_tabs, { desc = '[S]earch [T]abs' })
  end,
}
