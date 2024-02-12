return {
  'shortcuts/no-neck-pain.nvim',
  config = function()
    require('no-neck-pain').setup({
      width = 150,
      -- width = 100,
      autocmds = {
        enableOnVimEnter = false,
      },
      mappings = {
        enabled = true,
      },
      -- buffers = {
      --   right = {
      --     enabled = false,
      --   },
      -- },
      integrations = {
        NvimTree = {
          reopen = false,
        },
      },
    })
  end,
}
