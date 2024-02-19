local function apply_theme()
  vim.cmd.colorscheme('arctic')
  vim.api.nvim_set_hl(0, 'LineNr', { fg = '#333333' })
  vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#333333' })
  vim.api.nvim_set_hl(0, 'GitSignsCurrentLineBlame', { fg = '#444444' })
  vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupBorder', { link = 'FloatBorder' })
  vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupBorderSearch', { link = 'FloatBorder' })

  -- vim.cmd('T2CSelect easy')
  -- vim.api.nvim_set_hl(0, 'NormalFloat', { link = 'Normal' })
  -- vim.cmd.hi('T2CClr3Sign guibg=None')
  -- vim.cmd.hi('T2CClr6Sign guibg=None')
end

return {
  { 'rose-pine/neovim' },

  { 'luisiacc/gruvbox-baby' },

  {
    'rockyzhang24/arctic.nvim',
    branch = 'v2',
    dependencies = { 'rktjmp/lush.nvim' },
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
      apply_theme()
    end,
  },
}
