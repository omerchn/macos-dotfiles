-- return {
--   'lunarvim/darkplus.nvim',
--   priority = 1000,
--   config = function()
--     vim.cmd.colorscheme 'darkplus'
--   end,
-- }

return {
  'rose-pine/neovim',
  priority = 1000,
  config = function()
    vim.cmd.colorscheme 'rose-pine'
    vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'TelescopeBorder', { bg = 'none' })
  end,
}
