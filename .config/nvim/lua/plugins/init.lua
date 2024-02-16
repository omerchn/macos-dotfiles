return {
  -- detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- keep cursor centered at end of file
  -- { 'Aasim-A/scrollEOF.nvim', config = {} },

  -- auto close brackets
  { 'windwp/nvim-autopairs',  event = 'InsertEnter', opts = {} },

  -- show pending keybinds
  { 'folke/which-key.nvim',   opts = {} },

  -- 'gc' to comment visual regions/lines
  { 'numToStr/Comment.nvim',  opts = {} },

  -- surround
  { 'kylechui/nvim-surround', event = 'VeryLazy',    opts = {} },

  -- mutiple cursors
  { 'mg979/vim-visual-multi' },

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
      vim.cmd('T2CSelect easy')
    end,
  },
}
