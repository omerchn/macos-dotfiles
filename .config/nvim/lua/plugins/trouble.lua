return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('trouble').setup({
      use_diagnostic_signs = true,
      auto_jump = { 'lsp_definitions', 'lsp_type_definitions' },
      auto_fold = true, -- automatically fold a file trouble list at creation
    })

    vim.keymap.set('n', 'gd', function()
      require('trouble').toggle('lsp_definitions')
    end, { desc = 'Goto Definition' })
    vim.keymap.set('n', 'gr', function()
      require('trouble').toggle('lsp_references')
    end, { desc = 'Goto References' })
    vim.keymap.set('n', 'gD', function()
      require('trouble').toggle('lsp_type_definitions')
    end)
    vim.keymap.set('n', 'gI', function()
      require('trouble').toggle('lsp_implementations')
    end)
    vim.keymap.set('n', '<leader>dl', function()
      require('trouble').toggle('document_diagnostics')
    end, { desc = 'List Diagnostics' })
    vim.keymap.set('n', '<leader>dL', function()
      require('trouble').toggle('workspace_diagnostics')
    end, { desc = 'List Workspace Diagnostics' })
  end,
}
