return {
  'folke/noice.nvim',
  dependencies = { 'MunifTanjim/nui.nvim' },
  config = function()
    require('noice').setup({
      routes = {
        {
          filter = {
            event = 'msg_show',
            kind = '',
            find = 'written',
          },
          opts = { skip = true },
        },
      },
    })

    require('telescope').load_extension('noice')

    local border_color = '#111111'
    vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupBorderSearch', { fg = border_color })
    vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupBorder', { fg = border_color })
  end,
}
