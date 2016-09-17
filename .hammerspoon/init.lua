hs.hotkey.bind({"ctrl"}, "pad0", function()
  hs.execute("/usr/local/bin/mpc toggle")
end)
hs.hotkey.bind({"ctrl"}, "pad5", function()
  hs.execute("/usr/local/bin/mpc stop")
end)
hs.hotkey.bind({"ctrl"}, "pad1", function()
  hs.execute("/usr/local/bin/mpc prev")
end)
hs.hotkey.bind({"ctrl"}, "pad3", function()
  hs.execute("/usr/local/bin/mpc next")
end)
hs.hotkey.bind({"ctrl"}, "pad4", function()
  hs.execute("/usr/local/bin/mpc seek -1%")
end)
hs.hotkey.bind({"ctrl"}, "pad6", function()
  hs.execute("/usr/local/bin/mpc seek +1%")
end)

-- Not ideal, doesn't open new window
hs.hotkey.bind({"alt", "shift"}, "return", function()
  hs.application.launchOrFocus("iTerm")
end)

--[[ Doesn't work =\
hs.hotkey.bind({"alt"}, "p", function()
  hs.application.launchOrFocus("Spotlight")
end)
--]]

--[[ TODO
[xpaste] = Shift+Insert
[lock screen] = MOD+Shift+Delete
[vol_mute] = Control+KP_Delete
[vol_down] = Control+KP_Down
[vol_up] = Control+KP_Up
--]]
