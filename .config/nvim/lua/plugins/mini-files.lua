return {
  'echasnovski/mini.files',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    vim.api.nvim_set_keymap('n', '<leader>m', ':lua MiniFiles.open()<CR>', { silent = true, desc = '[E]xplore' })

    require('mini.files').setup({
      mappings = {
        close = '<esc>'
      },
      options = {
        use_as_default_explorer = false,
      },
    })
  end
}
