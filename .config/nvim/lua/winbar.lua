local use_icons = true

local function isempty(s)
  return s == nil or s == ''
end

local winbar_filetype_exclude = {
  'NeogitCommitMessage',
  'netrw',
  'help',
  'startify',
  'dashboard',
  'lazy',
  'neo-tree',
  'neogitstatus',
  'NvimTree',
  'Trouble',
  'alpha',
  'lir',
  'Outline',
  'git',
  'spectre_panel',
  'toggleterm',
  'DressingSelect',
  'Jaq',
  'harpoon',
  'dap-repl',
  'dap-terminal',
  'dapui_console',
  'dapui_hover',
  'lab',
  'notify',
  'noice',
  'neotest-summary',
  'no-neck-pain',
  'minifiles',
  '',
}

local get_filename = function()
  local filepath = vim.fn.expand('%:.:h')
  local filename = vim.fn.expand('%:t')
  local extension = vim.fn.expand('%:e')

  if not isempty(filename) then
    local file_icon, hl_group
    local devicons_ok, devicons = pcall(require, 'nvim-web-devicons')
    if use_icons and devicons_ok then
      file_icon, hl_group = devicons.get_icon(filename, extension, { default = true })

      if isempty(file_icon) then
        file_icon = ''
      end
    else
      file_icon = ''
      hl_group = 'WinBar'
    end

    return ' '
        .. '%#LspCodeLens#'
        .. filepath
        .. ' '
        .. '%#'
        .. hl_group
        .. '#'
        .. file_icon
        .. '%*'
        .. ' '
        .. '%#WinBar#'
        .. filename
        .. ' %m'
        --
        .. ' %*'
  end
end

local excludes = function()
  return vim.tbl_contains(winbar_filetype_exclude or {}, vim.bo.filetype)
end

local function get_marks()
  local harpoon = require('harpoon.mark')
  local active = harpoon.get_current_index()
  local length = harpoon.get_length()
  local str = ''
  for i = 1, length, 1 do
    if i == active then
      str = str .. ' %#WarningMsg#' .. i .. '%*'
    else
      str = str .. ' ' .. i .. ''
    end
  end

  return str
end

local get_winbar = function()
  if excludes() then
    return
  end
  local value = get_filename()
  -- local value = get_marks()

  local status_ok, _ = pcall(vim.api.nvim_set_option_value, 'winbar', value, { scope = 'local' })
  if not status_ok then
    return
  end
end

vim.api.nvim_create_augroup('_winbar', {})
vim.api.nvim_create_autocmd({
  'CursorHoldI',
  'CursorHold',
  'BufWinEnter',
  'BufEnter',
  'BufRead',
  'BufReadPost',
  'BufFilePost',
  'InsertEnter',
  'BufWritePost',
  'TabClosed',
  'TabEnter',
}, {
  group = '_winbar',
  callback = function()
    local status_ok, _ = pcall(vim.api.nvim_buf_get_var, 0, 'lsp_floating_window')
    if not status_ok then
      get_winbar()
    end
  end,
})
