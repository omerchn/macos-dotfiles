return {
  {
    'lunarvim/darkplus.nvim',
    config = function()
      -- vim.cmd.colorscheme 'darkplus'
    end,
  },

  {
    'rose-pine/neovim',
    config = function()
      require('rose-pine').setup({ styles = { italic = false } })
      -- vim.cmd.colorscheme 'rose-pine'
    end,
  },

  {
    'luisiacc/gruvbox-baby',
    config = function()
      vim.cmd.colorscheme 'gruvbox-baby'
    end,
  }
}
