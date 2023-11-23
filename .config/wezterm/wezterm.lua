local wezterm = require 'wezterm'
local utils = require 'utils'

local config = {}

local colors = {
  white = '#ccc',
  gray = '#555',
  black = '#111',
}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

wezterm.on("gui-startup", function()
  local _, _, window = wezterm.mux.spawn_window {}
  window:gui_window():maximize()
end)

wezterm.on('update-right-status', function(window)
  local workspaces = wezterm.mux.get_workspace_names()
  local active_workspace = wezterm.mux.get_active_workspace()
  local fomart_list = {}

  for _, v in ipairs(workspaces) do
    if v == active_workspace then
      utils.push(fomart_list,
        { Attribute = { Intensity = 'Bold' } },
        { Foreground = { Color = colors.white } },
        { Text = ' ' .. v .. ' ' }
      )
    else
      utils.push(fomart_list,
        'ResetAttributes',
        { Attribute = { Intensity = 'Half' } },
        { Foreground = { Color = colors.gray } },
        { Text = ' ' .. v .. ' ' }
      )
    end
  end

  window:set_right_status(wezterm.format(fomart_list))
end)


local fav_themes = {
  breath = 'Breath (Gogh)',
  nord = 'nord',
  synthwave = 'Synthwave (Gogh)',
  sublette = 'Sublette',
  bat = 'Batman'
}
config.color_scheme = fav_themes.bat
config.default_prog = { '/opt/homebrew/bin/fish', '-l' }
config.default_cwd = '~/Desktop'
config.font_size = 15
config.font = wezterm.font 'JetBrains Mono'
config.window_background_opacity = 1
config.window_decorations = "RESIZE"
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_max_width = 9999999999
config.colors = {
  cursor_bg = 'white',
  cursor_fg = 'black',
  tab_bar = {
    background = colors.black,
    active_tab = {
      bg_color = colors.black,
      fg_color = colors.white,
    },
    inactive_tab = {
      bg_color = colors.black,
      fg_color = colors.gray,
    },
    new_tab = {
      bg_color = colors.black,
      fg_color = colors.black,
    },
  }
}
config.inactive_pane_hsb = {
  saturation = 1,
  brightness = 0.8,
}
config.window_padding = {
  top    = '0.5cell',
  bottom = 0,
  left   = '1cell',
  right  = '1cell'
}


config.keys = {
  { mods = "CMD", key = "LeftArrow",  action = wezterm.action.SendKey({ mods = "CTRL", key = "a" }) },
  { mods = "CMD", key = "RightArrow", action = wezterm.action.SendKey({ mods = "CTRL", key = "e" }) },
  { mods = "CMD", key = "Backspace",  action = wezterm.action.SendKey({ mods = "CTRL", key = "u" }) },
}

local no_ops_cmd = {
  'm', 'q'
}

for _, key in ipairs(no_ops_cmd) do
  table.insert(config.keys, {
    key = key,
    mods = 'CMD',
    action = wezterm.action.DisableDefaultAssignment
  })
end


local dir_keys = {
  Left = 'h',
  Down = 'j',
  Up = 'k',
  Right = 'l'
}

for k, v in pairs(dir_keys) do
  table.insert(config.keys, {
    key = v,
    mods = 'CMD',
    action = wezterm.action.ActivatePaneDirection(k),
  })

  table.insert(config.keys, {
    key = v,
    mods = 'ALT|CMD',
    action = wezterm.action.AdjustPaneSize { k, 5 },
  })

  table.insert(config.keys, {
    key = v,
    mods = 'CTRL|ALT|CMD',
    action = wezterm.action.SplitPane {
      direction = k,
      size = { Percent = 50 },
    },
  })
end

local scroll_keys = { k = -1, j = 1 }

for key, value in pairs(scroll_keys) do
  table.insert(config.keys, {
    key = key,
    mods = 'SHIFT|CMD',
    action = wezterm.action.ScrollByLine(value)
  })
end

table.insert(config.keys, {
  key = 'p',
  mods = 'CMD',
  action = wezterm.action.ShowLauncherArgs {
    flags = 'FUZZY|WORKSPACES',
    title = 'Workspaces'
  },
})

table.insert(config.keys, {
  key = 'n',
  mods = 'CMD',
  action = wezterm.action.PromptInputLine {
    description = wezterm.format {
      { Attribute = { Intensity = 'Bold' } },
      { Text = 'Enter name for new workspace (leave blank for random name)' },
    },
    action = wezterm.action_callback(function(window, pane, line)
      if line then
        if line ~= '' then
          window:perform_action(
            wezterm.action.SwitchToWorkspace {
              name = line,
            },
            pane
          )
        else
          window:perform_action(
            wezterm.action.SwitchToWorkspace,
            pane
          )
        end
      end
    end),
  },
})

table.insert(config.keys, {
  key = 'r',
  mods = 'CMD',
  action = wezterm.action.PromptInputLine {
    description = wezterm.format {
      { Attribute = { Intensity = 'Bold' } },
      { Text = 'Enter new name for workspace' },
    },
    action = wezterm.action_callback(function(_, _, line)
      if line ~= '' then
        wezterm.mux.rename_workspace(
          wezterm.mux.get_active_workspace(),
          line
        )
      end
    end),
  },
})

local nav_keys = { LeftArrow = -1, RightArrow = 1 }

for key, value in pairs(nav_keys) do
  table.insert(config.keys, {
    key = key, mods = 'CMD|CTRL', action = wezterm.action.SwitchWorkspaceRelative(value)
  })
end
table.insert(config.keys, {
  key = 'n', mods = 'CMD|SHIFT', action = wezterm.action.SwitchWorkspaceRelative(-1)
})
table.insert(config.keys, {
  key = 'p', mods = 'CMD|SHIFT', action = wezterm.action.SwitchWorkspaceRelative(1)
})

for key, value in pairs(nav_keys) do
  table.insert(config.keys, {
    key = key, mods = 'CMD|ALT', action = wezterm.action.ActivateTabRelative(value)
  })
end


return config
