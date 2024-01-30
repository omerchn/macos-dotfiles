return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup {
      theme = 'hyper',
      shortcut_type = 'number',
      config = {
        header = {
          '██████╗ ███╗   ███╗███████╗██████╗ ███████╗',
          '██╔═══██╗████╗ ████║██╔════╝██╔══██╗██╔════╝',
          '██║   ██║██╔████╔██║█████╗  ██████╔╝███████╗',
          '██║   ██║██║╚██╔╝██║██╔══╝  ██╔══██╗╚════██║',
          '╚██████╔╝██║ ╚═╝ ██║███████╗██║  ██║███████║',
          '╚═════╝ ╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝',
          ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
          ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
          ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
          ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
          ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
          ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
          'cwd: ' .. vim.fn.getcwd(),
          ''
        },
        shortcut = {
          {
            desc = '󰍉 Find Files',
            group = 'Character',
            key = 'f',
            action = 'Telescope find_files'
          },
        },
        packages = { enable = false },
        project = { enable = false },
        mru = { limit = 6, icon = '󰔛 ', label = 'Recent Files', cwd_only = true },
        footer = {}, -- footer
      }
    }
  end,
  dependencies = { { 'nvim-tree/nvim-web-devicons' } }
}
