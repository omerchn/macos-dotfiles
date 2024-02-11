local M = {}

function M.get_ivy(extra_opts)
  extra_opts = extra_opts or {}
  -- The default opts for ivy theme can be found here https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/themes.lua
  local opts = {
    results_title = false,
    prompt_title = false,
    previewer = true,
    preview_title = '',
    -- borderchars = {
    --   -- Left border only
    --   preview = { '', '', '', '│', '│', '', '', '│' },
    -- },
    layout_config = {
      height = 0.6,
    },
  }
  return require('telescope.themes').get_ivy(vim.tbl_deep_extend('force', opts, extra_opts))
end

return M
