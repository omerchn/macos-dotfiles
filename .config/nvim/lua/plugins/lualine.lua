local colors = {
  fg = '#c6c6c6',
  bg = 'None',
}

local active_sections = {
  lualine_a = { 'branch', 'diff' },
  lualine_b = {},
  lualine_c = {},
  lualine_x = {},
  lualine_y = {},
  lualine_z = { 'diagnostics' },
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
