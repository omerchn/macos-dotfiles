return {
  -- detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- keep cursor centered at end of file
  { 'Aasim-A/scrollEOF.nvim', config = {} },

  -- auto close brackets
  { 'm4xshen/autoclose.nvim', config = {} },

  -- show pending keybinds
  { 'folke/which-key.nvim',   opts = {} },

  -- 'gc' to comment visual regions/lines
  { 'numToStr/Comment.nvim',  opts = {} },

  -- surround
  { 'kylechui/nvim-surround', opts = {},  event = 'VeryLazy' },

  -- mutiple cursors
  { 'mg979/vim-visual-multi' },
}
