local function apply_theme()
  --

  vim.cmd.colorscheme('arctic')
  vim.api.nvim_set_hl(0, 'Normal', { bg = 'None' })
  vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'None' })
  vim.api.nvim_set_hl(0, 'LineNr', { fg = '#333333' })
  vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#1F1F1F' })
  vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#222222' })
  vim.api.nvim_set_hl(0, 'GitSignsCurrentLineBlame', { fg = '#444444' })
  vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupBorder', { link = 'FloatBorder' })
  vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupBorderSearch', { link = 'FloatBorder' })
  vim.api.nvim_set_hl(0, 'WinSeparator', { fg = '#1F1F1F' })

  -- vim.cmd.colorscheme('rose-pine')
  -- vim.api.nvim_set_hl(0, 'Normal', { bg = 'None' })
  -- -- vim.api.nvim_set_hl(0, 'NormalNC', { bg = 'None' })
  -- vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'None' })
  -- vim.cmd.hi('FloatBorder guibg=None')
  -- vim.api.nvim_set_hl(0, 'WinBar', { bg = 'None' })
  -- -- vim.api.nvim_set_hl(0, 'LineNr', { fg = '#25233A' })
  -- -- vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#6C6883' })

  -- vim.cmd('T2CSelect easy')
  -- vim.api.nvim_set_hl(0, 'NormalFloat', { link = 'Normal' })
  -- vim.cmd.hi('T2CClr3Sign guibg=None')
  -- vim.cmd.hi('T2CClr6Sign guibg=None')
  -- vim.cmd.hi('SignColumn guibg=None')

  -- vim.cmd.colorscheme('solarized-osaka')
  -- vim.cmd.hi('LineNr guifg=#333333')
  -- vim.cmd.hi('CursorLineNr guifg=#333333')
  -- vim.cmd.hi('WinSeparator guifg=' .. Osaka_bg_color)

  --
end

return {
  {
    'rockyzhang24/arctic.nvim',
    branch = 'v2',
    dependencies = {
      'rktjmp/lush.nvim',
      'rose-pine/neovim',
      'luisiacc/gruvbox-baby',
      {
        'craftzdog/solarized-osaka.nvim',
        config = function()
          Osaka_bg_color = ''
          require('solarized-osaka').setup({
            transparent = false,
            ---@param colors ColorScheme
            on_colors = function(colors)
              Osaka_bg_color = colors.bg
            end,
          })
        end,
      },
      {
        'svermeulen/text-to-colorscheme',
        config = function()
          require('text-to-colorscheme').setup({
            ai = {
              openai_api_key = os.getenv('OPENAI_API_KEY'),
            },
            hex_palettes = {
              {
                name = 'easy',
                background_mode = 'dark',
                background = '#1e2024',
                foreground = '#a7aaa8',
                accents = {
                  '#cc6666',
                  '#929389',
                  '#a3685a',
                  '#507873',
                  '#9aa158',
                  '#85678f',
                  '#81a2be',
                },
              },
            },
            default_palette = 'easy',
          })
        end,
      },
    },
    config = function()
      apply_theme()
    end,
  },
}
