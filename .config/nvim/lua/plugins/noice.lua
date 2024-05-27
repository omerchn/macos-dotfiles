return {
  'folke/noice.nvim',
  dependencies = { 'MunifTanjim/nui.nvim' },
  cond = not vim.g.started_by_firenvim,
  config = function()
    require('noice').setup({
      -- cmdline = {
      --   view = 'cmdline',
      -- },
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
