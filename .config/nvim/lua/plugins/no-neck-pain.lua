return {
  "shortcuts/no-neck-pain.nvim",
  config = function()
    require("no-neck-pain").setup({
      width = 150,
      autocmds = {
        enableOnVimEnter = true,
      },
      mappings = {
        enabled = true,
      },
      buffers = {
        -- setNames = true,
      },
      integrations = {
        NvimTree = {
          reopen = false,
        }
      }
    })
  end
}
