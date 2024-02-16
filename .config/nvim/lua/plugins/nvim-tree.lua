-- uncomment for float tree
-- local HEIGHT_RATIO = 0.9

return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    -- uncomment for sidebar tree auto open
    -- local function open_nvim_tree()
    --   require('nvim-tree.api').tree.toggle({ focus = false })
    -- end
    -- vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
    --

    vim.keymap.set('n', '<leader>e', function()
      -- uncomment for sidebar tree
      require('nvim-tree.api').tree.toggle({ focus = false })

      -- uncomment for float tree
      -- vim.cmd('NvimTreeToggle')
    end, { silent = true, desc = '[E]xplore' })

    require('nvim-tree').setup({
      sort_by = 'case_sensitive',
      hijack_netrw = true,
      respect_buf_cwd = true,
      sync_root_with_cwd = true,
      update_focused_file = { enable = true },
      view = {
        adaptive_size = true,
        relativenumber = vim.wo.relativenumber and true or false,

        -- uncomment for float tree
        -- float = {
        --   enable = true,
        --   open_win_config = function()
        --     vim.api.nvim_set_hl(0, 'NvimTreeNormal', { bg = 'NONE' })
        --     local screen_w = vim.opt.columns:get()
        --     local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
        --     local window_w = 75
        --     local window_h = screen_h * HEIGHT_RATIO
        --     local window_w_int = math.floor(window_w)
        --     local window_h_int = math.floor(window_h)
        --     local center_x = (screen_w - window_w) / 2
        --     local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
        --     return {
        --       border = 'solid',
        --       relative = 'editor',
        --       row = center_y,
        --       col = center_x,
        --       width = window_w_int,
        --       height = window_h_int,
        --     }
        --   end,
        -- },
        --
      },
      filters = {
        git_ignored = false,
      },
      diagnostics = {
        enable = true,
      },
      renderer = {
        indent_width = 2,
        group_empty = true,
        indent_markers = {
          enable = true,
        },
      },
      on_attach = function(bufnr)
        local api = require('nvim-tree.api')

        local function opts(desc)
          return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- default mappings
        api.config.mappings.default_on_attach(bufnr)

        -- custom mappings
        vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))

        vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
        vim.keymap.set('n', '<Right>', api.node.open.edit, opts('Open'))

        vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close parent'))
        vim.keymap.set('n', '<Left>', api.node.navigate.parent_close, opts('Close parent'))

        vim.keymap.set('n', '<ESC>', api.tree.close, opts('Close tree'))
      end,
    })
  end,
}
