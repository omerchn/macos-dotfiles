return {
  'nvimtools/none-ls.nvim',
  config = function()
    local null_ls = require('null-ls')
    null_ls.setup({
      sources = {
        -- js/ts
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettierd.with({
          env = {
            PRETTIERD_DEFAULT_CONFIG = vim.fn.expand('~/.config/nvim/utils/linter-config/.prettierrc.json'),
          },
        }),
        null_ls.builtins.diagnostics.eslint_d,
        -- python
        null_ls.builtins.formatting.black,
      },
    })
  end,
}
