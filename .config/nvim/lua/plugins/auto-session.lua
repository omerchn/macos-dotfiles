return {
  'rmagatti/auto-session',
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('auto-session').setup({
      log_level = 'error',
      auto_session_enabled = true,
      auto_save_enabled = false,
      auto_restore_enabled = true,
      auto_session_suppress_dirs = { '/' },
      post_restore_cmds = { 'SessionDelete' },
    })
    vim.keymap.set('n', '<leader>S', function()
      vim.cmd('SessionSave')
      vim.cmd('qa')
    end, { desc = 'Quit all and save session' })
  end,
}
