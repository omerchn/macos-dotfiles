return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('toggleterm').setup({
        open_mapping = [[<C-t>]],
        direction = 'float',
        float_opts = {
          -- The border key is *almost* the same as 'nvim_open_win'
          -- see :h nvim_open_win for details on borders however
          -- the 'curved' border is a custom border type
          -- not natively supported but implemented in this plugin.
          border = 'single', -- | 'double' | 'shadow' | 'curved' | ... other options supported by win open
          -- like `size`, width, height, row, and col can be a number or function which is passed the current terminal
          -- width = <value>,
          -- height = <value>,
          -- row = <value>,
          -- col = <value>,
          -- winblend = 3,
          -- zindex = <value>,
          title_pos = 'center',
        },
      })

      function _G.set_terminal_keymaps()
        local opts = { buffer = 0 }
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set('t', '<C-t>', [[<Cmd>ToggleTerm<CR>]], opts)
        -- vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
        vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
      end

      vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

      for i = 1, 9 do
        vim.keymap.set({ 'n', 'x', 'o' }, '<leader>t' .. i, ':ToggleTerm ' .. i .. '<cr>',
          { desc = 'ToggleTerm - to terminal ' .. i })
      end
    end,
  },
  {
    'ryanmsnyder/toggleterm-manager.nvim',
    config = function()
      local toggleterm_manager = require('toggleterm-manager')
      local telescope_actions = require('telescope.actions')
      local actions_state = require('telescope.actions.state')

      local function toggle_full_term(prompt_bufnr)
        local selection = actions_state.get_selected_entry()
        if selection == nil then
          return
        end

        local term = selection.value

        telescope_actions.close(prompt_bufnr)
        term:open()
      end

      local maps = {
        ['<CR>'] = { action = toggle_full_term },
        ['<C-i>'] = { action = function() end },
        ['<C-d>'] = { action = toggleterm_manager.actions.delete_term, exit_on_action = false },
        ['<C-r>'] = { action = toggleterm_manager.actions.rename_term, exit_on_action = false },
      }

      toggleterm_manager.setup({
        mappings = {
          i = maps,
          n = maps,
        },
        titles = {
          prompt = ' Terminals',
          results = '',
          preview = 'Output Preview',
        },
      })

      vim.keymap.set('n', '<leader>st', function()
        require('toggleterm-manager').open({
          initial_mode = 'normal',
          prompt_prefix = '',
        })
      end)
    end,
  },
}
