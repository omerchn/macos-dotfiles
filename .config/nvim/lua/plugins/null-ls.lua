return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    local null_ls = require('null-ls')
    null_ls.setup({
      sources = {
        -- lua
        null_ls.builtins.formatting.stylua,

        -- js/ts
        null_ls.builtins.formatting.prettierd.with({
          env = {
            PRETTIERD_DEFAULT_CONFIG = vim.fn.expand('~/.config/nvim/utils/linter-config/.prettierrc.json'),
          },
        }),
        require("none-ls.diagnostics.eslint_d").with({
          condition = function(utils)
            return utils.root_has_file({ '.eslintrc.js', '.eslintrc.cjs', '.eslintrc' })
          end,
        }),
        null_ls.builtins.formatting.black,
      },
    })
  end,
}
