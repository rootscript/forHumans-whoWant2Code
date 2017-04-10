
-------------------------------------------------------------------------------------
-- Hammerspoon config ------------------------------------------------------ START --
-------------------------------------------------------------------------------------
hs.window.animationDuration = 0--0.1
hs.hotkey.alertDuration=0
hs.hints.showTitleThresh = 20
hs.hints.fontSize = 14
hs.hints.style = "vimperator"
-- hs.alert.defaultStyle [{textSize = 8}, {radius = '11'}]
-------------------------------------------------------------------------------------
-- http://www.hammerspoon.org/docs/hs.ipc.html
hs.ipc.cliInstall()
-- require('hs.ipc')
-- Provides the server portion of the Hammerspoon command line interface
-------------------------------------------------------------------------------------
-- Hammerspoon API Documentation
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "/", "hs. API docs", function()
    hs.hsdocs()
    hs.task.new('/usr/bin/say', nil, {'Loading, Hammerspoon API docs'}):start()
end)
--KEYS:: {"cmd", "alt", "ctrl"}, "/", "hs. API docs"
-------------------------------------------------------------------------------------
-- Hammerspoon config -------------------------------------------------------- END --
-------------------------------------------------------------------------------------




-------------------------------------------------------------------------------------
-- Unused but useful -------------------------------------------------------- START--
-------------------------------------------------------------------------------------
-- perhist console history across launches
-- hs.shutdownCallback = function() hs.settings.set('history', hs.console.getHistory()) end
-- hs.console.setHistory(hs.settings.get('history'))

-- -- suppress warnings
-- hs.luaSkinLog.setLogLevel("warning")
-- hs.hotkey.setLogLevel("warning")
-- hs.window.filter.setLogLevel("error")
-------------------------------------------------------------------------------------
-- TODO:: setup window filters & subscribe to events ( app opened, closed, minimised )
-- local log = hs.logger.new('debug', 'debug')

-- local filter = hs.window.filter.new(true)
-- filter:subscribe(
--   hs.window.filter.windowCreated,
--   (function(window, applicationName)
--     log.wf('got a callback from %s', applicationName)
--   end),
--   true
-- )
-------------------------------------------------------------------------------------
-- Unused but useful ---------------------------------------------------------- END--
-------------------------------------------------------------------------------------




-------------------------------------------------------------------------------------
-- Basic console auto-hide when Hammerspoon loses focus -----------------------------
-------------------------------------------------------------------------------------
ConsoleWatcher = hs.application.watcher.new(function(name,event,hsapp)
    if name then
        if name:match("Hammerspoon") and event == hs.application.watcher.deactivated then
            local test = hs.appfinder.windowFromWindowTitle("Hammerspoon Console")
            if test then test:close() end
        end
    end
end)
ConsoleWatcher:start()
--   Turns on the watcher, and if the Hammerspoon console is open, closes it when you switch to another application
-- ConsoleWatcher:stop()
--   Turns off the watcher; Hammerspoon console open/close state is left untouched.
-------------------------------------------------------------------------------------




-------------------------------------------------------------------------------------
-- This Section is ALL Modifier & Hotkey related
-------------------------------------------------------------------------------------
ca = {"ctrl", "alt"}
cac = {"ctrl", "alt", "cmd"}
cc = {"ctrl", "cmd"}
-------------------------------------------------------------------------------------




-------------------------------------------------------------------------------------
-- This Section is ALL about requiring other modules
-------------------------------------------------------------------------------------
-- load a more minimal config if running from xcode
if hs.processInfo.bundlePath:match("/Users/rootsript/Library/Developer/Xcode/DerivedData/") then
-- if hs.window.focusedWindow() == ('Code') then
  require "i_xcodebuild"
  return
end

--*********************************************************
-- Capture the hostname, so we can make this config behave differently across my Macs
hostname = hs.host.localizedName()

-- Load various modules from ~/.hammerspoon/ depending on which machine this is
if (hostname == "mMini") then
    hs.alert.show("displayLayouts.hostname = mMini")
    -- require('i_someModule')
end

 -- require('i_someModule_to_load_for_ALL_machines')

if (hostname == "mbPro") then
    hs.alert.show("displayLayouts.hostname = mbPro !!!")
    -- require('i_someModule')
end
--*********************************************************

-- Define monitor names to be used for layout
-- display_imac = "iMac"
-- display_mbpro = "Color LCD"--LG 34 inch Ultrawide
-- display_syncmaster = "SyncMaster"-- display at boston manor
-- display_monitor = "Thunderbolt Display"
-- display_lg = "LG ULTRAWIDE"
-------------------------------------------------------------------------------------




-------------------------------------------------------------------------------------
-- This Section is ALL Browser & WebView related
-------------------------------------------------------------------------------------
-- nothing commited yet



-------------------------------------------------------------------------------------
-- This Section is ALL Window Switching & Moving related
-------------------------------------------------------------------------------------

-- Bind alt-Tab to show next window of current application
hs.hotkey.bind({"alt"}, "Tab", "hs: Next Window of Focussed App", function()
	local app = hs.application.frontmostApplication()
	local windows = app:allWindows()
	
	local nextWin = nil
	
	-- Finder somehow has one more invisible window, so don't take it into account
	-- (only tested on Yosemite 10.10.1)
	if app:bundleID() == "com.apple.finder" then
		nextWin = windows[#windows-1]
	else
		nextWin = windows[#windows]
	end

	if nextWin:isMinimized() == true then
		nextWin:unminimize()
	else
		nextWin:focus()
	end
end)
-- {"alt"}, "Tab", "hs: Next Window of Focussed App"




-------------------------------------------------------------------------------------
-- This Section is ALL Window Switching & Moving related
-------------------------------------------------------------------------------------
-- nothing commited yet




-------------------------------------------------------------------------------------
-- KWM window manager config ----------------------------------------------- START --
-------------------------------------------------------------------------------------
-- if (hostname == "mMini") then
--     require('i_kwmCommands') -- I have split out kwm command to separate config file
-- end
-- setup kwm config per machine & display, and maybe per application
-- // Set default values for screen padding Top | Bottom | Left | Right
-- kwmc config padding 50 36 76 44
-- // Set default values for container gaps
-- kwmc config gap 15 15

-- {"shift", "alt"}, "right", "kwm: Focus win RIGHT"
  -- +-----------------+
  -- |        |        |
  -- |        |  HERE  |
  -- |        |        |
  -- +-----------------+
-- {"shift", "alt"}, "left", "kwm: Focus win LEFT"
  -- +-----------------+
  -- |        |        |
  -- |  HERE  |        |
  -- |        |        |
  -- +-----------------+
-- {"shift", "alt"}, "up", "kwm: Focus win UP"
  -- +-----------------+
  -- |      HERE       |
  -- +-----------------+
  -- |                 |
  -- +-----------------+
-- {"shift", "alt"}, "down", "kwm: Focus win DOWN"
  -- +-----------------+
  -- |                 |
  -- +-----------------+
  -- |      HERE       |
  -- +-----------------+

-- {"ctrl", "cmd"}, "right", "kwm: Move win RIGHT"
  -- +-----------------+
  -- |        |        |
  -- |        |  HERE  |
  -- |        |        |
  -- +-----------------+
-- {"ctrl", "cmd"}, "left", "kwm: Move win LEFT"
  -- +-----------------+
  -- |        |        |
  -- |  HERE  |        |
  -- |        |        |
  -- +-----------------+
-- {"ctrl", "cmd"}, "up", "kwm: Move win UP"
  -- +-----------------+
  -- |      HERE       |
  -- +-----------------+
  -- |                 |
  -- +-----------------+
-- {"ctrl", "cmd"}, "down", "kwm: Move win DOWN"
  -- +-----------------+
  -- |                 |
  -- +-----------------+
  -- |      HERE       |
  -- +-----------------+

-- {"ctrl", "cmd"}, "V", "kwm: Split mode Vertical"
  -- +-----------------+
  -- |        |        |
  -- |        |        |
  -- |        |        |
  -- +-----------------+
-- {"ctrl", "cmd"}, "H", "kwm: Split mode Horizontal"
  -- +-----------------+
  -- |                 |
  -- +-----------------+
  -- |                 |
  -- +-----------------+
-- {"ctrl", "cmd"}, "O", "kwm: Split mode Optimal"

-- {"ctrl", "cmd"}, "T", "kwmToggle: Display Split Mode: Ver | Hor | Opt"
-- {"ctrl", "cmd"}, "'", "kwmToggle: Container Split Mode: Hor | Ver | Opt"

-- {"cmd", "shift"}, "down", "kwm: Container Split Ratio: expand North"
-- {"cmd", "shift"}, "up", "kwm: Container Split Ratio: expand South"
-- {"cmd", "shift"}, "left", "kwm: Container Split Ratio: expand West"
-- {"cmd", "shift"}, "right", "kwm: Container Split Ratio: expand East"

-- {"alt", "shift"}, "R", "kwm: Resize all windows to their container size"
-- {"alt", "shift"}, "F", "kwm: Float"

-- {"ctrl", "shift"}, "B", "kwm: Tree bsp"
-- {"ctrl", "shift"}, "N", "kwm: Toogle Tree: monocale | bsp"

-- {"ctrl", "shift"}, "M", "kwm: Tree Monocale"
-- {"ctrl", "shift"}, "c", "kwm: Monocle Previous"
-- {"ctrl", "shift"}, "v", "kwm: Monocle Next"

-- {"ctrl", "shift"}, "R", "kwm: restart service"
-- {"ctrl", "shift"}, "S", "kwm: Stop service"
-- {"ctrl", "shift"}, "Q", "kwm: Quit"


-- {"ctrl", "shift"}, "O", "kwm: Rotate Tree 90"
-------------------------------------------------------------------------------------
-- KWM window manager config ------------------------------------------------- END --
-------------------------------------------------------------------------------------




-------------------------------------------------------------------------------------
-- Watchers for file changes to ~/Desktop and /Library/LaunchAgents/ ------- START --
-------------------------------------------------------------------------------------
--watch for files changes in .txt or .lua files
function DesktopWatcher(files)
    for _,file in pairs(files) do
        if file:sub(-4) == ".txt" then
            hs.alert.show("Desktop .txt file was modified")
        elseif file:sub(-4) == ".lua" then
            hs.alert.show("Desktop .lua file was modified")
        -- else
        --   hs.alert.show("Desktop was modified")
        end
    end
end
-- local myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
local myLaunchAgentsWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/Library/LaunchAgents/", LaunchAgentsWatcher):start()
local mydesktopWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/Desktop/", DesktopWatcher):start()
-------------------------------------------------------------------------------------
-- Watchers for file changes to ~/Desktop and /Library/LaunchAgents/ --------- END --
-------------------------------------------------------------------------------------




-------------------------------------------------------------------------------------
-- Hammerspoon Reload other config files from ~/.hammerspoon directory ----- START --
-------------------------------------------------------------------------------------
-- keep this at the end of my init.lua
function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end

local myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
-- hs.alert.show("Config reloaded")
hs.alert.show("Config reloaded 👍")

function LaunchAgentsWatcher(files)
    hs.alert.show("Launch Agents folder was modified")
end
-------------------------------------------------------------------------------------
-- Hammerspoon Reload other config files from ~/.hammerspoon directory ------- END --
-------------------------------------------------------------------------------------