return {
  'rcarriga/nvim-notify',
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('notify').setup({
      background_colour = '#eeeeee',
      stages = 'slide',
      timeout = 1000,
      render = 'compact',
      fps = 60,
    })

    vim.api.nvim_create_autocmd('RecordingEnter', {
      callback = function()
        vim.notify(vim.fn.reg_recording(), vim.log.levels.INFO, {
          title = 'Recording Macro',
        })
      end,
    })

    vim.api.nvim_create_autocmd('RecordingLeave', {
      callback = function()
        vim.notify(vim.fn.reg_recording(), vim.log.levels.INFO, {
          title = 'Recorded Macro',
        })
      end,
    })
  end,
}
