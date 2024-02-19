return {
  'shortcuts/no-neck-pain.nvim',
  config = function()
    require('no-neck-pain').setup({
      width = 150,
      autocmds = {
        enableOnVimEnter = false,
      },
      mappings = {
        enabled = true,
      },
      integrations = {
        NvimTree = {
          reopen = false,
        },
      },
    })
  end,
}
