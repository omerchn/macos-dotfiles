return {
  -- subword motion
  {
    -- 'chrisgrieser/nvim-spider',
    -- keys = {
    --   {
    --     'e',
    --     "<cmd>lua require('spider').motion('e')<CR>",
    --     mode = { 'n', 'o', 'x' },
    --   },
    --   {
    --     'w',
    --     "<cmd>lua require('spider').motion('w')<CR>",
    --     mode = { 'n', 'o', 'x' },
    --   },
    --   {
    --     'b',
    --     "<cmd>lua require('spider').motion('b')<CR>",
    --     mode = { 'n', 'o', 'x' },
    --   },
    -- },
  },

  -- subword text object
  {
    "chrisgrieser/nvim-various-textobjs",
    lazy = false,
    config = function()
      vim.keymap.set({ "o", "x" }, "as", '<cmd>lua require("various-textobjs").subword("outer")<CR>')
      vim.keymap.set({ "o", "x" }, "is", '<cmd>lua require("various-textobjs").subword("inner")<CR>')
      require('various-textobjs').setup({ useDefaultKeymaps = false })
    end
  }
}
