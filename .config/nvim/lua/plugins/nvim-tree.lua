return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    vim.keymap.set('n', '<leader>e', function()
      require('nvim-tree.api').tree.toggle({ focus = false })
    end, { silent = true, desc = '[E]xplore' })

    require('nvim-tree').setup({
      sort_by = 'case_sensitive',
      hijack_netrw = true,
      respect_buf_cwd = true,
      sync_root_with_cwd = true,
      update_focused_file = { enable = true },
      actions = {
        open_file = { resize_window = false },
      },
      view = {
        relativenumber = vim.wo.relativenumber and true or false,
        width = 50,
      },
      filters = {
        git_ignored = false,
        custom = { '.DS_Store' },
      },
      diagnostics = {
        enable = true,
        icons = {
          hint = 'H',
          info = 'I',
          warning = 'W',
          error = 'E',
        },
      },
      renderer = {
        indent_width = 2,
        group_empty = true,
        indent_markers = {
          enable = true,
        },
        icons = {
          glyphs = {
            git = {
              unstaged = '~',
              staged = '✓',
              unmerged = '',
              renamed = '➜',
              untracked = '+',
              deleted = '-',
              ignored = '◌',
            },
          },
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

    -- local function open_nvim_tree(data)
    --   -- buffer is a real file on the disk
    --   local real_file = vim.fn.filereadable(data.file) == 1
    --
    --   -- buffer is a [No Name]
    --   local no_name = data.file == '' and vim.bo[data.buf].buftype == ''
    --
    --   if not real_file and not no_name then
    --     return
    --   end
    --
    --   -- open the tree, find the file but don't focus it
    --   require('nvim-tree.api').tree.toggle({ focus = false, find_file = true })
    -- end
    -- vim.api.nvim_create_autocmd({ 'VimEnter' }, { callback = open_nvim_tree })
  end,
}
