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
  end,
}
