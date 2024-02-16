local colors = {
  fg = '#c6c6c6',
  bg = '#1a1a1a',
}

local active_sections = {
  lualine_a = { { 'filename', path = 1 }, 'diff', 'diagnostics' },
  lualine_b = {},
  lualine_c = {},
  lualine_x = {},
  lualine_y = {},
  lualine_z = { 'branch' },
}

local inactive_sections = {
  lualine_a = {},
  lualine_b = {},
  lualine_c = {},
  lualine_x = {},
  lualine_y = {},
  lualine_z = {},
}

return {
  'nvim-lualine/lualine.nvim',
  opts = {
    options = {
      theme = {
        normal = {
          a = { fg = colors.fg, bg = colors.bg },
          b = { fg = colors.fg, bg = colors.bg },
          c = { fg = colors.fg, bg = colors.bg },
        },
      },
      icons_enabled = true,
      component_separators = '',
      section_separators = '',
    },
    sections = active_sections,
    inactive_sections = inactive_sections,
    tabline = {},
    extensions = {},
  },
}
