-- -----------------
-- Setup environment
-- -----------------

-- Animation off, turn on speed
hs.window.animationDuration = 0

-- Get list of screens and refresh that list whenever screens are (un)plugged
local screens = hs.screen.allScreens()
local screenwatcher = hs.screen.watcher.new(function()
    screens = hs.screen.allScreens()
end)
screenwatcher:start()

-- Modifier shortcuts
local hyper = {"⌥", "⇧"}
local alt = {"⌥"}
local pushkey = {"⌃", "⌘"}
local pushShiftkey = {"⌃", "⌘", "⇧"}

-- Tracking variables
local pressed = {
  up = false,
  down = false,
  left = false,
  right = false
}

-- Full screen sizes
local fullScreenSizeIndex = 0
local fullScreenSizes = {
    { x = 0.00, y = 0.00, w = 1.0, h = 1.0 },
    { x = 0.05, y = 0.05, w = 0.9, h = 0.9 },
    { x = 0.10, y = 0.10, w = 0.8, h = 0.8 },
    { x = 0.15, y = 0.15, w = 0.7, h = 0.7 },
    { x = 0.20, y = 0.20, w = 0.6, h = 0.6 },
    { x = 0.25, y = 0.25, w = 0.5, h = 0.5 }
}


-- ----------------
-- Helper functions
-- ----------------

-- Resize window for chunk of screen.
-- For x and y: use 0 to expand fully in that dimension, 0.5 to expand halfway
-- For w and h: use 1 for full, 0.5 for half
function push(x, y, w, h)
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x + (max.w*x)
    f.y = max.y + (max.h*y)
    f.w = max.w*w
    f.h = max.h*h
    win:setFrame(f)
end

-- Shortcuts for pushing to top, bottom, left, right in every combination
function pushT()  push(0.0, 0.0, 1.0, 0.5) end
function pushB()  push(0.0, 0.5, 1.0, 0.5) end
function pushL()  push(0.0, 0.0, 0.5, 1.0) end
function pushSL() push(0.0, 0.0, 0.8, 1.0) end
function pushR()  push(0.5, 0.0, 0.5, 1.0) end
function pushSR() push(0.2, 0.0, 0.8, 1.0) end
function pushTL() push(0.0, 0.0, 0.5, 0.5) end
function pushTR() push(0.5, 0.0, 0.5, 0.5) end
function pushBL() push(0.0, 0.5, 0.5, 0.5) end
function pushBR() push(0.5, 0.5, 0.5, 0.5) end


-- Move to monitor x. Checks to make sure monitor exists, if not moves to last monitor that exists
function moveToMonitor(x)
    local win = hs.window.focusedWindow()
    local newScreen = nil
    while not newScreen do
        newScreen = screens[x]
        x = x-1
    end
    win:moveToScreen(newScreen)
end

-- -----------------
-- Window management
-- -----------------

-- Push to left (including top left and bottom left)
hs.hotkey.bind(pushkey, "left", function()
    pressed.left = true
    if pressed.up then
        pushTL()
    elseif pressed.down then
        pushBL()
    else
        pushL()
    end
end, function ()
    pressed.left = false
end)

-- Push to left but larger
hs.hotkey.bind(pushShiftkey, "left", function()
    pushSL()
end)

-- Push to right (including top right and bottom right)
hs.hotkey.bind(pushkey, "right", function()
    pressed.right = true
    if pressed.up then
        pushTR()
    elseif pressed.down then
        pushBR()
    else
        pushR()
    end
end, function()
    pressed.right = false
end)

-- Push to right but larger
hs.hotkey.bind(pushShiftkey, "right", function()
  pushSR()
end)

-- Push to top (including top right and top left)
hs.hotkey.bind(pushkey, "up", function()
    pressed.up = true
    if pressed.left then
        pushTL()
    elseif pressed.right then
        pushTR()
    else
        pushT()
    end
end, function()
    pressed.up = false
end)

-- Push to bottom (including bottom left and bottom right)
hs.hotkey.bind(pushkey, "down", function()
    pressed.down = true
    if pressed.left then
        pushBL()
    elseif pressed.right then
        pushBR()
    else
        pushB()
    end
end, function()
    pressed.down = false
end)

-- Center window with some room to see the desktop
hs.hotkey.bind(pushkey, "m", function() push(0.05,0.00,0.9,1.0) end)

-- Center window with some room to see the desktop
hs.hotkey.bind(alt, "space", function() push(0.0,0.0,1.0,1.0) end)

-- Move a window between monitors
hs.hotkey.bind(pushkey, "1", function() moveToMonitor(1) end) -- Move to first monitor
hs.hotkey.bind(pushkey, "2", function() moveToMonitor(2) end) -- Move to second monitor

-- Tile windows on current screen
hs.hotkey.bind({'cmd', 'ctrl'}, 't', function()
    local wins = hs.window.filter.new():setCurrentSpace(true):getWindows()
    local screen = hs.screen.mainScreen():currentMode()
    local rect = hs.geometry(0, 0, screen['w'], screen['h'])
    hs.window.tiling.tileWindows(wins, rect)
end)


-- -------------
-- "Full" screen
-- -------------

-- Cycle through "full" screen sizes
hs.hotkey.bind(pushkey, "f", function()
    fullScreenSizeIndex = fullScreenSizeIndex + 1
    if fullScreenSizeIndex > #fullScreenSizes then fullScreenSizeIndex = 1 end
    size = fullScreenSizes[fullScreenSizeIndex]
    push(size.x, size.y, size.w, size.h)
end)

-- Watch for focus changes to reset the full screen size cycling
allwindows = hs.window.filter.new(nil)
allwindows:subscribe(hs.window.filter.windowUnfocused, function () fullScreenSizeIndex = 0 end)


-- ---------------------
-- Application shortcuts
-- ---------------------

appmode = hs.hotkey.modal.new({"cmd"}, "E")
appmode:bind({}, "B", function() hs.application.launchOrFocus("Google Chrome") appmode:exit() end)
appmode:bind({}, "C", function() hs.application.launchOrFocus("Calendar") appmode:exit() end)
appmode:bind({}, "D", function() hs.application.launchOrFocus("Postico") appmode:exit() end)
appmode:bind({}, "S", function() hs.application.launchOrFocus("Slack") appmode:exit() end)
appmode:bind({}, "T", function() hs.application.launchOrFocus("cmux") appmode:exit() end)


-- -----------------------
-- Configuration reloading
-- -----------------------

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

hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")
