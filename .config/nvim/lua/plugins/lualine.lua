local colors = {
  fg = '#c6c6c6',
  bg = '#1A1A1A',
}

local sections = {
  lualine_a = { 'branch', 'diff' },
  lualine_b = {},
  lualine_c = {},
  lualine_x = {},
  lualine_y = {},
  lualine_z = { 'diagnostics' },
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
        --
        -- insert = { a = { fg = status_line_colors.blue, bg = nil } },
        -- visual = { a = { fg = status_line_colors.cyan, bg = nil } },
        -- replace = { a = { fg = status_line_colors.red, bg = nil } },
        --
        -- inactive = {
        --   a = { fg = status_line_colors.white, bg = nil },
        --   b = { fg = status_line_colors.white, bg = nil },
        --   c = { fg = status_line_colors.white, bg = nil },
        -- },
      },
      icons_enabled = true,
      component_separators = '',
      section_separators = '',
    },
    sections = sections,
    inactive_sections = sections,
    tabline = {},
    extensions = {},
  },
}
