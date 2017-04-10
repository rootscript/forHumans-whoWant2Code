-------------------------------------------------------------------------------------
-- Change Window Focus to NESW
-------------------------------------------------------------------------------------
hs.hotkey.bind({"shift", "alt"}, "right", "kwm: Focus win RIGHT", function()
  local appName = hs.window.focusedWindow():application():title()
  hs.alert.show(appName .. ' Focus to East')
  os.execute("/usr/local/bin/kwmc window -f east")
end)

hs.hotkey.bind({"shift", "alt"}, "left", "kwm: Focus win LEFT", function()
  local appName = hs.window.focusedWindow():application():title()
  hs.alert.show(appName .. ' Focus to West')
  os.execute("/usr/local/bin/kwmc window -f west")
end)

hs.hotkey.bind({"shift", "alt"}, "up", "kwm: Focus win UP", function()
  local appName = hs.window.focusedWindow():application():title()
  hs.alert.show(appName .. ' Focus to North')
  os.execute("/usr/local/bin/kwmc window -f north")
end)

hs.hotkey.bind({"shift", "alt"}, "down", "kwm: Focus win DOWN", function()
  local appName = hs.window.focusedWindow():application():title()
  hs.alert.show(appName .. ' Focus to South')
  os.execute("/usr/local/bin/kwmc window -f south")
end)


---------------------------------------------------------
-- Move Focussed Window to Around
-- this conflicts with CMD CTRL ARROWS in iTerm2
-- FIX https://github.com/Hammerspoon/hammerspoon/issues/272#issuecomment-96085256
---------------------------------------------------------
-- Create a modal hotkey object with an absurd triggering hotkey, since it will never be triggered from the keyboard
hotkeys = hs.hotkey.modal.new({"cmd", "shift", "alt"}, "F19")

hotkeys:bind({"ctrl", "cmd"}, "right", "kwm: Move win RIGHT", function()
  local appName = hs.window.focusedWindow():application():title()
  hs.alert.show(appName .. ' to East')
  os.execute("/usr/local/bin/kwmc window -s east")
end)

hotkeys:bind({"ctrl", "cmd"}, "left", "kwm: Move win LEFT", function()
  local appName = hs.window.focusedWindow():application():title()
  hs.alert.show(appName .. ' to West')
  os.execute("/usr/local/bin/kwmc window -s west")
end)

hotkeys:bind({"ctrl", "cmd"}, "up", "kwm: Move win UP", function()
  local appName = hs.window.focusedWindow():application():title()
  hs.alert.show(appName .. ' to North')
  os.execute("/usr/local/bin/kwmc window -s north")
end)

hotkeys:bind({"ctrl", "cmd"}, "down", "kwm: Move win DOWN", function()
  local appName = hs.window.focusedWindow():application():title()
  hs.alert.show(appName .. ' to South')
  os.execute("/usr/local/bin/kwmc window -s south")
end)
-- this conflicts with CMD CTRL ARROWS in iTerm2
-- SO changed hs.hotkey.bind to hotkeys:bind


--[[hotkeys:bind({"shift", "alt"}, "right", "kwm: Focus win RIGHT", function()
  local appName = hs.window.focusedWindow():application():title()
  hs.alert.show(appName .. ' Focus to East')
  os.execute("/usr/local/bin/kwmc window -f east")
end)

hotkeys:bind({"shift", "alt"}, "left", "kwm: Focus win LEFT", function()
  local appName = hs.window.focusedWindow():application():title()
  hs.alert.show(appName .. ' Focus to West')
  os.execute("/usr/local/bin/kwmc window -f west")
end)

hotkeys:bind({"shift", "alt"}, "up", "kwm: Focus win UP", function()
  local appName = hs.window.focusedWindow():application():title()
  hs.alert.show(appName .. ' Focus to North')
  os.execute("/usr/local/bin/kwmc window -f north")
end)

hotkeys:bind({"shift", "alt"}, "down", "kwm: Focus win DOWN", function()
  local appName = hs.window.focusedWindow():application():title()
  hs.alert.show(appName .. ' Focus to South')
  os.execute("/usr/local/bin/kwmc window -f south")
end)]]

-- Define a callback function to be called when application events happen
function applicationWatcherCallback(appName, eventType, appObject)
  if (appName == "iTerm2") then
    if (eventType == hs.application.watcher.activated) then
      -- iTerm2 just got focus, disable our hotkeys
      hotkeys:exit()
      hs.alert.show("iTerm2 activated")
    elseif (eventType == hs.application.watcher.deactivated) then
      -- iTerm2 just lost focus, enable our hotkeys
      hotkeys:enter()
      hs.alert.show("iTerm2 deactivated")
    end
  elseif (appName == "Code") then
    if (eventType == hs.application.watcher.activated) then
      -- iTerm2 just got focus, disable our hotkeys
      -- hotkeys:exit()
      hs.alert.show("Code activated")
    elseif (eventType == hs.application.watcher.deactivated) then
      -- iTerm2 just lost focus, enable our hotkeys
      -- hotkeys:enter()
      hs.alert.show("Code deactivated")
    end
  -- end
  -- elseif appName ~= "Code" or "iTerm2" then
  elseif appName ~= "" then
    hs.dockicon.setBadge(appName)
  end
end

-- Create and start the application event watcher
watcher = hs.application.watcher.new(applicationWatcherCallback)
watcher:start()

-- Activate the modal state
hotkeys:enter()
---------------------------------------------------------

---------------------------------------------------------
-- Set active split-mode of display
-- optimal | vertical | horizontal
---------------------------------------------------------
hs.hotkey.bind({"ctrl", "cmd"}, "V", "kwm: Split mode Vertical", function()
  local appName = hs.window.focusedWindow():application():title()
  hs.alert.show('Split mode Vertical')
  os.execute("/usr/local/bin/kwmc display -c vertical")
end)
hs.hotkey.bind({"ctrl", "cmd"}, "H", "kwm: Split mode Horizontal", function()
  local appName = hs.window.focusedWindow():application():title()
  hs.alert.show('Split mode Horizontal')
  os.execute("/usr/local/bin/kwmc display -c horizontal")
end)
hs.hotkey.bind({"ctrl", "cmd"}, "O", "kwm: Split mode Optimal", function()
  local appName = hs.window.focusedWindow():application():title()
  hs.alert.show('Split mode Optimal')
  os.execute("/usr/local/bin/kwmc display -c optimal")
end)
---------------------------------------------------------
-- TOGGLE3 options for active split-mode of display
-- optimal | vertical | horizontal
---------------------------------------------------------
displaySplitModeStatus = nil

local function toggle_display_split_mode()
-- IMPORTANT - use hs.execute instead of os.execute which only returns true
-- Also use printf to flatten return to 1 line, and awk to pull the 1st column
-- Also add extra brackets to around command
-- FINALLY got it to work
  displaySplitModeStatus = hs.execute("printf `/usr/local/bin/kwmc query tiling split-mode | awk '{print $1}'`")
  if displaySplitModeStatus == 'Vertical' then
    hs.alert.show("Vertical so changing to Horizontal")
    os.execute("/usr/local/bin/kwmc display -c horizontal")
  end
  if displaySplitModeStatus == 'Horizontal' then
    hs.alert.show("Horizontal so changing to Optimal")
    os.execute("/usr/local/bin/kwmc display -c optimal")
  end
  if displaySplitModeStatus == 'Optimal' then
    hs.alert.show("Optimal so changing to Vertical")
    os.execute("/usr/local/bin/kwmc display -c vertical")
  elseif displaySplitModeStatus ~= 'Horizontal' or 'Vertical' or 'Optimal' then
  -- elseif not (displaySplitModeStatus == 'Horizontal' or displaySplitModeStatus == 'Vertical' or displaySplitModeStatus == 'Optimal') then--JUST ANOTHER WAY of doing the above line
    hs.alert.show("Check code starting line 721")
  end
end
hs.hotkey.bind({"ctrl", "cmd"}, "T", "kwmToggle: Display Split Mode: Ver | Hor | Opt", function()
  -- hs.alert.show((hs.execute("printf `/usr/local/bin/kwmc query tiling split-mode | awk '{print $1}'`")))
  toggle_display_split_mode()
  -- hs.alert.show("toggle_display_split_mode")
end)
---------------------------------------------------------

---------------------------------------------------------
-- Toggle Container Split Mode - Vertical or Horizontal
---------------------------------------------------------
hs.hotkey.bind({"ctrl", "cmd"}, "'", "kwmToggle: Container Split Mode: Hor | Ver | Opt", function()
  local appName = hs.window.focusedWindow():application():title()
  hs.alert.show('Split mode Container Toggle')
  os.execute("/usr/local/bin/kwmc window -c split-mode toggle")
end)
---------------------------------------------------------

---------------------------------------------------------
-- Change Container Split Ratios
---------------------------------------------------------
hs.hotkey.bind({"cmd", "shift"}, "down", "kwm: Container Split Ratio: expand North",function()
  local appName = hs.window.focusedWindow():application():title()
  hs.alert.show(appName .. ' expand North')
  os.execute("/usr/local/bin/kwmc window -c expand 0.05 south")
end)
hs.hotkey.bind({"cmd", "shift"}, "up", "kwm: Container Split Ratio: expand South", function()
  local appName = hs.window.focusedWindow():application():title()
  hs.alert.show(appName .. ' expand South')
  os.execute("/usr/local/bin/kwmc window -c reduce 0.05 south")
end)
hs.hotkey.bind({"cmd", "shift"}, "left", "kwm: Container Split Ratio: expand West", function()
  local appName = hs.window.focusedWindow():application():title()
  hs.alert.show(appName .. ' expand West')
  os.execute("/usr/local/bin/kwmc window -c reduce 0.05 east")
end)
hs.hotkey.bind({"cmd", "shift"}, "right", "kwm: Container Split Ratio: expand East",function()
  local appName = hs.window.focusedWindow():application():title()
  hs.alert.show(appName .. ' expand East')
  os.execute("/usr/local/bin/kwmc window -c expand 0.05 east")
end)
---------------------------------------------------------
hs.hotkey.bind({"alt", "shift"}, "F", "kwm: Float", function()
  os.execute("/usr/local/bin/kwmc config tiling float;")
  hs.alert.show("kwm float")
end)
hs.hotkey.bind({"alt", "shift"}, "R", "kwm: Resize all windows to their container size", function()
  os.execute("/usr/local/bin/kwmc space -r focussed")
  hs.alert.show("kwm: Resize all windows to their container size")
end)
---------------------------------------------------------

---------------------------------------------------------

hs.hotkey.bind({"ctrl", "shift"}, "B", "kwm: Tree bsp", function()
  os.execute("/usr/local/bin/kwmc window -c type bsp")
  hs.alert.show("kwm: tree: bsp")
end)
hs.hotkey.bind({"ctrl", "shift"}, "N", "kwm: Toogle Tree: monocale | bsp", function()
  os.execute("/usr/local/bin/kwmc window -c type toggle")
  hs.alert.show("kwm: toogle tree: monocle | bsp")
end)

hs.hotkey.bind({"ctrl", "shift"}, "M", "kwm: Tree Monocale", function()
  os.execute("/usr/local/bin/kwmc window -c type monocle")
  hs.alert.show("kwm: tree: monocle")
end)
hs.hotkey.bind({"ctrl", "shift"}, "c", "kwm: Monocle Previous", function()
  os.execute("/usr/local/bin/kwmc window -fm prev")
  -- os.execute("/usr/local/bin/brewbrew services restart khd;")
  hs.alert.show("kwm: Monocle Previous")
end)
hs.hotkey.bind({"ctrl", "shift"}, "v", "kwm: Monocle Next", function()
  os.execute("/usr/local/bin/kwmc window -fm next")
  -- os.execute("/usr/local/bin/brewbrew services restart khd;")
  hs.alert.show("kwm: Monocle Next")
end)
---------------------------------------------------------

---------------------------------------------------------
hs.hotkey.bind({"ctrl", "shift"}, "R", "kwm: Restart service", function()
  os.execute("/usr/local/bin/brew services restart kwm;")
  os.execute("/usr/local/bin/brewbrew services restart khd;")
  hs.alert.show("Restarting kwm & khd services")
end)
hs.hotkey.bind({"ctrl", "shift"}, "S", "kwm: Stop service", function()
  os.execute("/usr/local/bin/brew services stop kwm;")
  os.execute("/usr/local/bin/brewbrew services stop khd;")
  hs.alert.show("Stopping kwm & khd services")
end)

-- hs.hotkey.bind({"ctrl", "shift"}, 'Q', hs.execute("kwmc quit"))
hs.hotkey.bind({"ctrl", "shift"}, "Q", "kwm: Quit", function()
  os.execute("/usr/local/bin/kwmc quit;")
  os.execute("/usr/local/bin/brew services stop kwm;")
  os.execute("/usr/local/bin/brew services stop khd;")
  hs.alert.show("quit kwm & stop kwm & khd services")
end)
---------------------------------------------------------

---------------------------------------------------------
-- Rotate Window-Tree by 90degrees (Clockwise)
hs.hotkey.bind({"ctrl", "shift"}, "O", "kwm: Rotate Tree 90", function()
  os.execute("/usr/local/bin/kwmc tree rotate 90;")
  hs.alert.show("kwm r90")
end)

---------------------------------------------------------







-- UNUSED Commands

---------------------------------------------------------
-- Move Focussed Window to Space
---------------------------------------------------------
--[[hs.hotkey.bind({"ctrl", "alt"}, "right", function()
  local appName = hs.window.focusedWindow():application():title()
  hs.alert.show(appName .. ' to Right Space')
  os.execute("/usr/local/bin/kwmc window -m space right")
end)

hs.hotkey.bind({"ctrl", "alt"}, "left", function()
  local appName = hs.window.focusedWindow():application():title()
  hs.alert.show(appName .. ' to Left Space')
  os.execute("/usr/local/bin/kwmc window -m space left")
end)

hs.hotkey.bind({"ctrl", "alt"}, "1", function()
  local appName = hs.window.focusedWindow():application():title()
  hs.alert.show(appName .. ' to Space 0')
  os.execute("/usr/local/bin/kwmc space -m 0")
end)
hs.hotkey.bind({"ctrl", "alt"}, "2", function()
  local appName = hs.window.focusedWindow():application():title()
  hs.alert.show(appName .. ' to Space 2')
  os.execute("/usr/local/bin/kwmc space -m 1")
end)
hs.hotkey.bind({"ctrl", "alt"}, "3", function()
  local appName = hs.window.focusedWindow():application():title()
  hs.alert.show(appName .. ' to Space 3')
  os.execute("/usr/local/bin/kwmc space -m 2")
end)]]


--LINK::  https://gist.github.com/koekeishiya/cf19a150a615fff6c2fb4fe9207d97c6
-- Move the focused window to a new space and give it focus

--[[kwmc=/usr/local/bin/kwmc
dir=$1
if [ "$dir" = "previous" ]
then
    dir=$(kwmc query space previous)
    $kwmc window -m space previous
else
    $kwmc window -m space $dir
fi
sleep 0.25
$kwmc space -f $dir]]














---------------------------------------------------------
-- kwm Scratchpad
--[[hs.hotkey.bind({"ctrl", "shift"}, "]", "kwm: Scratchpad Add", function()
  os.execute("/usr/local/bin/kwmc scratchpad add;")
  hs.alert.show("kwm Scratch +")
end)
hs.hotkey.bind({"ctrl", "shift"}, "[", "kwm: Scratchpad Remove", function()
  os.execute("/usr/local/bin/kwmc scratchpad remove;")
  hs.alert.show("kwm Scratch -")
end)
hs.hotkey.bind({"ctrl", "shift"}, "P", "kwm: Scratchpad Toggle", function()
  os.execute("/usr/local/bin/kwmc scratchpad toggle;")
  hs.alert.show("kwm Scratchpad Toggle")
end)
]]
---------------------------------------------------------