return {
  'petertriho/nvim-scrollbar',
  config = function()
    require('scrollbar').setup({
      handle = {
        blend = 0,
        highlight = 'CursorLine',
      },
      marks = {
        Cursor = {
          text = ' ',
          priority = 999,
        },
      },
      handlers = {
        cursor = true,
        diagnostic = true,
        gitsigns = true,
        handle = true,
        search = false, -- Requires hlslens
        ale = false, -- Requires ALE
      },
    })
  end,
}
