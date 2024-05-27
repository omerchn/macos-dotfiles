return {
  -- detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

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
    'glacambre/firenvim',

    -- Lazy load firenvim
    -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
    lazy = not vim.g.started_by_firenvim,
    build = function()
      vim.fn["firenvim#install"](0)
    end
  },
}
