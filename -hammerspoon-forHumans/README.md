##hammerspoon sample configurations:

<https://github.com/Hammerspoon/hammerspoon/wiki/Sample-Configurations>

---

just a place to start collecting my thoughts & notes about Hammerspoon & Lua

So far I'm loving Hammerspoon & Lua, very easy to create complex things, evening with no coding experience.

###init-basic

- Hammerspoon config
- Hammerspoon API Documentation shortcut
- Unused but useful (like persistent console history across hammerspoon launches etc...)
- Basic Hammerspoon console auto-hide when it loses focus
- Section for ALL Modifiers & Hotkeys
- Section for ALL about requiring other modules for different macchines like iMac, macMini etc... ( and loading a minimal cofig for Xcode)
- Section for ALL Browser & WebView related (nothing commited yet)
- Section for ALL Window Switching & Moving related (alt-Tab to show next window of current application)
- Section for ALL Window Switching & Moving related (nothing commited yet)
- Watchers for file changes to ~/Desktop and /Library/LaunchAgents/
- Hammerspoon Reload config files on change from ~/.hammerspoon folder

---
###init-kwm
The same as init-basic, includes short cuts for kwm window manager:

 - {"shift", "alt"}, "right", "kwm: Focus win RIGHT"
 - {"shift", "alt"}, "left", "kwm: Focus win LEFT"
 - {"shift", "alt"}, "up", "kwm: Focus win UP"
 - {"shift", "alt"}, "down", "kwm: Focus win DOWN"
 - {"ctrl", "cmd"}, "right", "kwm: Move win RIGHT"
 - {"ctrl", "cmd"}, "left", "kwm: Move win LEFT"
 - {"ctrl", "cmd"}, "up", "kwm: Move win UP"
 - {"ctrl", "cmd"}, "down", "kwm: Move win DOWN"
 - {"ctrl", "cmd"}, "V", "kwm: Split mode Vertical"
 - {"ctrl", "cmd"}, "H", "kwm: Split mode Horizontal"
 - {"ctrl", "cmd"}, "O", "kwm: Split mode Optimal"

---
 - {"ctrl", "cmd"}, "T", "kwmToggle: Display Split Mode: Ver | Hor | Opt"
 - {"ctrl", "cmd"}, "'", "kwmToggle: Container Split Mode: Hor | Ver | Opt"

---
 - {"cmd", "shift"}, "down", "kwm: Container Split Ratio: expand North"
 - {"cmd", "shift"}, "up", "kwm: Container Split Ratio: expand South"
 - {"cmd", "shift"}, "left", "kwm: Container Split Ratio: expand West"
 - {"cmd", "shift"}, "right", "kwm: Container Split Ratio: expand East"

---
 - {"alt", "shift"}, "R", "kwm: Resize all windows to their container size"
 - {"alt", "shift"}, "F", "kwm: Float"

 - {"ctrl", "shift"}, "B", "kwm: Tree bsp"
 - {"ctrl", "shift"}, "N", "kwm: Toogle Tree: monocale | bsp"
 - {"ctrl", "shift"}, "O", "kwm: Rotate Tree 90"

 - {"ctrl", "shift"}, "M", "kwm: Tree Monocale"
 - {"ctrl", "shift"}, "c", "kwm: Monocle Previous"
 - {"ctrl", "shift"}, "v", "kwm: Monocle Next"

---
 - {"ctrl", "shift"}, "R", "kwm: restart service"
 - {"ctrl", "shift"}, "S", "kwm: Stop service"
 - {"ctrl", "shift"}, "Q", "kwm: Quit"



