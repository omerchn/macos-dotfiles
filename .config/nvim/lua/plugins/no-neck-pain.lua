return {
  'shortcuts/no-neck-pain.nvim',
  config = function()
    require('no-neck-pain').setup({
      width = 100,
      autocmds = {
        enableOnVimEnter = true,
      },
      mappings = {
        enabled = true,
      },
      buffers = {
        right = {
          enabled = false
        }
      },
      integrations = {
        NvimTree = {
          reopen = false,
        }
      }
    })
  end
}
