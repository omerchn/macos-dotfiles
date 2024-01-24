local HEIGHT_RATIO = 0.8
local WIDTH_RATIO = 0.5

return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', { silent = true, desc = '[E]xplore' })

    require('nvim-tree').setup {
      sort_by = 'case_sensitive',
      disable_netrw = true,
      hijack_netrw = true,
      respect_buf_cwd = true,
      sync_root_with_cwd = true,
      update_focused_file = { enable = true },
      view = {
        relativenumber = vim.wo.relativenumber and true or false,
        float = {
          enable = true,
          open_win_config = function()
            local screen_w = vim.opt.columns:get()
            local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
            local window_w = screen_w * WIDTH_RATIO
            local window_h = screen_h * HEIGHT_RATIO
            local window_w_int = math.floor(window_w)
            local window_h_int = math.floor(window_h)
            local center_x = (screen_w - window_w) / 2
            local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
            return {
              border = 'rounded',
              relative = 'editor',
              row = center_y,
              col = center_x,
              width = window_w_int,
              height = window_h_int,
            }
          end,
        },
        width = function()
          return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
        end,
      },
      filters = {
        git_ignored = false,
        custom = { '.git', 'node_modules' },
      },
      diagnostics = {
        enable = true,
      },
      renderer = {
        indent_width = 1,
        group_empty = true,
      },
      on_attach = function(bufnr)
        vim.api.nvim_set_hl(0, 'NvimTreeNormal', { bg = 'NONE' })

        local api = require 'nvim-tree.api'

        local function opts(desc)
          return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- default mappings
        api.config.mappings.default_on_attach(bufnr)

        -- custom mappings
        vim.keymap.set('n', '?', api.tree.toggle_help, opts 'Help')

        vim.keymap.set('n', 'l', api.node.open.edit, opts 'Open')
        vim.keymap.set('n', '<Right>', api.node.open.edit, opts 'Open')

        vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts 'Close parent')
        vim.keymap.set('n', '<Left>', api.node.navigate.parent_close, opts 'Close parent')

        vim.keymap.set('n', '<ESC>', api.tree.close, opts 'Close tree')
      end,
    }
  end,
}
