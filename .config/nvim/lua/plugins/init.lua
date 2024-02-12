return {
  -- detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- keep cursor centered at end of file
  { 'Aasim-A/scrollEOF.nvim', config = {} },

  -- auto close brackets
  { 'm4xshen/autoclose.nvim', config = {} },

  -- show pending keybinds
  { 'folke/which-key.nvim', opts = {} },

  -- 'gc' to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- surround
  { 'kylechui/nvim-surround', opts = {}, event = 'VeryLazy' },

  -- mutiple cursors
  { 'mg979/vim-visual-multi' },

  {
    'smoka7/hop.nvim',
    version = '*',
    config = function()
      local hop = require('hop')
      local directions = require('hop.hint').HintDirection
      vim.keymap.set('', 'f', function()
        hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
      end, { remap = true })
      vim.keymap.set('', 'F', function()
        hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
      end, { remap = true })
      vim.keymap.set('', 't', function()
        hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
      end, { remap = true })
      vim.keymap.set('', 'T', function()
        hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
      end, { remap = true })
    end,
  },
}
