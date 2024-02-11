return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  ---@type Flash.Config
  opts = {
    modes = {
      char = {
        highlight = { backdrop = false },
        multi_line = false,
      },
      search = {
        enabled = false,
      },
    },
  },
  keys = {
    {
      'S',
      mode = {
        'n',
        -- 'x',
        'o',
      },
      function()
        require('flash').jump()
      end,
      desc = 'Flash',
    },
  },
}
