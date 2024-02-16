return {
  {
    'chrisgrieser/nvim-various-textobjs',
    lazy = false,
    config = function()
      require('various-textobjs').setup({ useDefaultKeymaps = false })
      vim.keymap.set({ 'o', 'x' }, 'as', '<cmd>lua require("various-textobjs").subword("outer")<CR>')
      vim.keymap.set({ 'o', 'x' }, 'is', '<cmd>lua require("various-textobjs").subword("inner")<CR>')

      -- start url opener https://github.com/chrisgrieser/nvim-various-textobjs?tab=readme-ov-file#smarter-gx

      local function openURL(url)
        local opener
        if vim.fn.has('macunix') == 1 then
          opener = 'open'
        elseif vim.fn.has('linux') == 1 then
          opener = 'xdg-open'
        elseif vim.fn.has('win64') == 1 or vim.fn.has('win32') == 1 then
          opener = 'start'
        end
        local openCommand = string.format("%s '%s' >/dev/null 2>&1", opener, url)
        vim.fn.system(openCommand)
      end

      vim.keymap.set('n', 'gX', function()
        require('various-textobjs').url()
        local foundURL = vim.fn.mode():find('v')
        if not foundURL then
          return
        end
        vim.cmd.normal({ '"zy', bang = true })
        local url = vim.fn.getreg('z')
        openURL(url)
      end, { desc = 'URL Opener' })

      -- end url opener
    end,
  },
}
