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
}
