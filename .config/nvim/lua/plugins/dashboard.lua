return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup({
      theme = 'hyper',
      shortcut_type = 'number',
      config = {
        header = {
          -- ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
          -- ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
          -- ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
          -- ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
          -- ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
          -- ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',

          '       _   __         _    ___         ',
          '      / | / /__  ____| |  / (_)_______ ',
          '     /  |/ / _ \\/ __ \\ | / / / __  __ \\',
          '    / /|  /  __/ /_/ / |/ / / / / / / /',
          '   /_/ |_/\\___/\\____/|___/_/_/ /_/ /_/ ',
          '',
        },
        shortcut = {
          {
            desc = '󰍉 Files',
            group = 'Character',
            key = 'f',
            action = 'Telescope find_files',
          },
          {
            desc = '󰍉 Git-Status',
            group = 'Character',
            key = 's',
            action = 'Telescope git_status initial_mode=normal prompt_prefix=""',
          },
        },
        packages = { enable = false },
        project = { enable = false },
        mru = { limit = 6, icon = '󰔛 ', label = 'Recent Files', cwd_only = true },
        footer = {},
      },
    })
  end,
  dependencies = { { 'nvim-tree/nvim-web-devicons' } },
}
