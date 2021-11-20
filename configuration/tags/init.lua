local awful = require('awful')
local gears = require('gears')
local icons = require('theme.icons')
local apps = require('configuration.apps')

local tags = {
  {
    icon = icons.code,
    type = 'code',
    defaultApp = apps.default.atom,
    screen = 1
  },
  {
    icon = icons.search,
    type = 'chrome',
    defaultApp = apps.default.vivaldi,
    screen = 1
  },
  {
    icon = icons.lab,
    type = 'lab',
    defaultApp = 'postman',
    screen = 1
  },
  {
    icon = icons.terminal,
    type = 'terminal',
    defaultApp = 'alacritty',
    screen = 1
  },
  {
    icon = icons.chrome,
    type = 'classes',
    defaultApp = apps.default.vivaldi,
    screen = 1
  },
  {
    icon = icons.social,
    type = 'meet',
    defaultApp = apps.default.vivaldi,
    screen = 1
  },
  {
    icon = icons.game,
    type = 'media',
    defaultApp = 'vlc',
    screen = 1
  },
  {
    icon = icons.music,
    type = 'music',
    defaultApp = apps.default.music,
    screen = 1
  },
  {
    icon = icons.chart,
    type = 'misc',
    defaultApp = apps.default.emacs,
    screen = 1
  }
}

awful.layout.layouts = {
  awful.layout.suit.tile,
  awful.layout.suit.max,
  awful.layout.suit.floating,
  awful.layout.suit.tile.left,
  awful.layout.suit.tile.bottom,
  awful.layout.suit.tile.top,
  awful.layout.suit.spiral,
  awful.layout.suit.spiral.dwindle,
  awful.layout.suit.max.fullscreen,
  awful.layout.suit.magnifier
}

awful.screen.connect_for_each_screen(
  function(s)
    for i, tag in pairs(tags) do
      awful.tag.add(
        i,
        {
          icon = tag.icon,
          icon_only = true,
          layout = awful.layout.suit.tile,
          gap_single_client = false,
          gap = 4,
          screen = s,
          defaultApp = tag.defaultApp,
          selected = i == 1
        }
      )
    end
  end
)

_G.tag.connect_signal(
  'property::layout',
  function(t)
    local currentLayout = awful.tag.getproperty(t, 'layout')
    if (currentLayout == awful.layout.suit.max) then
      t.gap = 0
    else
      t.gap = 4
    end
  end
)
