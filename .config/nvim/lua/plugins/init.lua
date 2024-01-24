return {
  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- Transparent background
  'xiyaowong/transparent.nvim',

  -- Keep cursor centered at end of file
  { 'Aasim-A/scrollEOF.nvim', config = {} },

  -- Auto close brackets
  { 'm4xshen/autoclose.nvim', config = {} },

  -- Show pending keybinds
  { 'folke/which-key.nvim',   opts = {} },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim',  opts = {} },

  -- centered cmd line
  { 'folke/noice.nvim',       opts = {},  dependencies = { "MunifTanjim/nui.nvim" } },

  -- surround
  { 'kylechui/nvim-surround', opts = {},  event = 'VeryLazy' }
}
