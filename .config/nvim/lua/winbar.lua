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

---@param file_rel_path string
---@param hl_group string
local get_file_display = function(file_rel_path, hl_group)
  local head = vim.fn.fnamemodify(file_rel_path, ':.:h')
  local tail = vim.fn.fnamemodify(file_rel_path, ':t')
  local extension = vim.fn.fnamemodify(file_rel_path, ':e')

  if isempty(tail) then
    return ''
  end

  local file_icon, icon_hl_group
  local devicons_ok, devicons = pcall(require, 'nvim-web-devicons')
  if use_icons and devicons_ok then
    file_icon, icon_hl_group = devicons.get_icon(tail, extension, { default = true })
    if isempty(file_icon) then
      file_icon = ''
    end
  else
    file_icon = ''
    icon_hl_group = 'WinBar'
  end

  local icon = '%#' .. icon_hl_group .. '#' .. file_icon .. '%*'

  return hl_group .. head .. ' ' .. icon .. ' ' .. hl_group .. tail
end

local excludes = function()
  return vim.tbl_contains(winbar_filetype_exclude or {}, vim.bo.filetype)
end

local function get_marks_display()
  local harpoon = require('harpoon')
  local items = harpoon:list().items
  if #items == 0 then
    return ''
  end
  local marks = {}
  for i = 1, #items, 1 do
    local file_rel_path = items[i].value

    local hl_group = '%#WinBar#'
    if file_rel_path == vim.fn.expand('%:.') then
      hl_group = '%#Normal#'
    end

    table.insert(marks, hl_group .. i .. ' ' .. get_file_display(file_rel_path, hl_group))
  end
  return table.concat(marks, ' %#WinBar#| ')
end

local current_file_in_marks = function()
  local harpoon = require('harpoon')
  local items = harpoon:list().items

  for _, item in ipairs(items) do
    if item.value == vim.fn.expand('%:.') then
      return true
    end
  end
end

local get_winbar = function()
  if excludes() then
    return
  end

  local current_file = get_file_display(vim.fn.expand('%:.'), '%#Normal#')
  local marks_display = get_marks_display()

  local winbar = '  ' .. marks_display

  if not current_file_in_marks() then
    if marks_display ~= '' then
      winbar = winbar .. ' %#WinBar#| '
    end
    winbar = winbar .. current_file
  end

  winbar = winbar .. ' %#Normal# %m'

  pcall(vim.api.nvim_set_option_value, 'winbar', winbar, { scope = 'local' })
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
