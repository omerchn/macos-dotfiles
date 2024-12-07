return {
  -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  build = ':TSUpdate',
  config = function()
    -- [[ Configure Treesitter ]]
    -- See `:help nvim-treesitter`
    require('nvim-treesitter.configs').setup({
      ignore_install = {},
      modules = {},
      sync_install = false,
      -- Add languages to be installed here that you want installed for treesitter
      ensure_installed = {
        'go',
        'lua',
        'python',
        'rust',
        'tsx',
        'typescript',
        'javascript',
        'vimdoc',
        'vim',
        'kdl',
        'html',
        'css',
        'markdown',
      },

      -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
      auto_install = true,

      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          -- init_selection = '<c-space>',
          node_incremental = 'm',
          -- scope_incremental = '<c-s>',
          node_decremental = 'n',
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['a='] = { query = '@assignment.outer', desc = 'Select outer part of an assignment' },
            ['i='] = { query = '@assignment.inner', desc = 'Select inner part of an assignment' },
            ['l='] = { query = '@assignment.lhs', desc = 'Select left hand side of an assignment' },
            ['r='] = { query = '@assignment.rhs', desc = 'Select right hand side of an assignment' },

            -- works for javascript/typescript files (custom capture in after/queries/ecma/textobjects.scm)
            ['a:'] = { query = '@property.outer', desc = 'Select outer part of an object property' },
            ['i:'] = { query = '@property.inner', desc = 'Select inner part of an object property' },
            ['l:'] = { query = '@property.lhs', desc = 'Select left part of an object property' },
            ['r:'] = { query = '@property.rhs', desc = 'Select right part of an object property' },

            ['aa'] = { query = '@parameter.outer', desc = 'Select outer part of a parameter/argument' },
            ['ia'] = { query = '@parameter.inner', desc = 'Select inner part of a parameter/argument' },

            ['ai'] = { query = '@conditional.outer', desc = 'Select outer part of a conditional' },
            ['ii'] = { query = '@conditional.inner', desc = 'Select inner part of a conditional' },

            ['al'] = { query = '@loop.outer', desc = 'Select outer part of a loop' },
            ['il'] = { query = '@loop.inner', desc = 'Select inner part of a loop' },

            ['ac'] = { query = '@call.outer', desc = 'Select outer part of a function call' },
            ['ic'] = { query = '@call.inner', desc = 'Select inner part of a function call' },

            ['af'] = { query = '@function.outer', desc = 'Select outer part of a method/function definition' },
            ['if'] = { query = '@function.inner', desc = 'Select inner part of a method/function definition' },
          },
        },
        lsp_interop = {
          enable = true,
          border = 'none',
          floating_preview_opts = {},
          peek_definition_code = {
            ['<leader>df'] = '@function.outer',
            ['<leader>dF'] = '@class.outer',
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            [']f'] = '@function.outer',
            [']a'] = '@parameter.outer',
          },
          goto_next_end = {
            [']F'] = '@function.outer',
            [']A'] = '@parameter.outer',
          },
          goto_previous_start = {
            ['[f'] = '@function.outer',
            ['[a'] = '@parameter.outer',
          },
          goto_previous_end = {
            ['[F'] = '@function.outer',
            ['[A'] = '@parameter.outer',
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ['<leader>a'] = '@parameter.inner',
          },
          swap_previous = {
            ['<leader>A'] = '@parameter.inner',
          },
        },
      },
    })
    -- local ts_repeat_move = require('nvim-treesitter.textobjects.repeatable_move')
    -- vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move)
    -- vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_opposite)
  end,
}
