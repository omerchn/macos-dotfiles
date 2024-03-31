return {
  {
    'chrisgrieser/nvim-various-textobjs',
    lazy = false,
    config = function()
      local textobjs = require('various-textobjs')
      textobjs.setup({ useDefaultKeymaps = false })
      vim.keymap.set({ 'o', 'x' }, 'as', function()
        textobjs.subword('outer')
      end)
      vim.keymap.set({ 'o', 'x' }, 'is', function()
        textobjs.subword('inner')
      end)
      vim.keymap.set({ 'o', 'x' }, 'ie', function()
        textobjs.visibleInWindow()
      end)
      vim.keymap.set({ 'o', 'x' }, 'ii', function()
        textobjs.indentation('inner', 'inner')
      end)
      vim.keymap.set({ 'o', 'x' }, 'ai', function()
        textobjs.indentation('outer', 'outer')
      end)

      -- smart url opener https://github.com/chrisgrieser/nvim-various-textobjs?tab=readme-ov-file#smarter-gx
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
        textobjs.url()
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
