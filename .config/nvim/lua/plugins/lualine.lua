local status_line_colors = {
  blue = '#80a0ff',
  cyan = '#79dac8',
  black = '#080808',
  white = '#c6c6c6',
  red = '#ff5189',
  violet = '#d183e8',
  grey = '#303030',
}

return {
  -- Set lualine as statusline
  'nvim-lualine/lualine.nvim',
  -- See `:help lualine.txt`
  opts = {
    options = {
      theme = {
        normal = {
          a = { fg = status_line_colors.violet, bg = nil },
          b = { fg = status_line_colors.white, bg = nil },
          c = { fg = status_line_colors.white, bg = nil },
        },

        insert = { a = { fg = status_line_colors.blue, bg = nil } },
        visual = { a = { fg = status_line_colors.cyan, bg = nil } },
        replace = { a = { fg = status_line_colors.red, bg = nil } },

        inactive = {
          a = { fg = status_line_colors.white, bg = nil },
          b = { fg = status_line_colors.white, bg = nil },
          c = { fg = status_line_colors.white, bg = nil },
        },
      },
      icons_enabled = true,
      component_separators = '•',
      section_separators = '',
    },
    sections = {
      lualine_a = {
        { 'mode', right_padding = 2 },
      },
      lualine_b = { 'branch', 'diff' },
      lualine_c = {
        -- 'filename'
      },
      lualine_x = { 'diagnostics' },
      lualine_y = {
        -- 'progress',
      },
      lualine_z = {},
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    extensions = {},
  },
}
