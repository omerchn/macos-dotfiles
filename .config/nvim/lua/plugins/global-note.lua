local get_project_name = function()
  local project_directory, err = vim.loop.cwd()
  if err then
    vim.notify(err, vim.log.levels.WARN)
    return nil
  end

  if project_directory then
    local project_name = vim.fs.basename(project_directory)
    if project_name == nil then
      vim.notify('Unable to get the project name', vim.log.levels.WARN)
      return nil
    end
    return project_name
  end
end

return {
  'backdround/global-note.nvim',
  config = function()
    local global_note = require('global-note')
    global_note.setup({
      additional_presets = {
        -- Presets that have the same fields as the table root (default preset).
        project_local = {
          filename = function()
            return get_project_name() .. '.md'
          end,
          title = 'Project note',
          command_name = 'ProjectNote',
        },
      },
    })

    vim.keymap.set('n', '<leader><C-n>', function()
      global_note.toggle_note('project_local')
    end, {
      desc = 'Toggle global note',
    })
  end,
}
