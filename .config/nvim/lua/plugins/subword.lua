return {
  {
    'chrisgrieser/nvim-various-textobjs',
    lazy = false,
    config = function()
      vim.keymap.set({ 'o', 'x' }, 'as', '<cmd>lua require("various-textobjs").subword("outer")<CR>')
      vim.keymap.set({ 'o', 'x' }, 'is', '<cmd>lua require("various-textobjs").subword("inner")<CR>')
      require('various-textobjs').setup({ useDefaultKeymaps = false })
    end,
  },
}
