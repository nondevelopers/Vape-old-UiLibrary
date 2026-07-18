-- ============================================================
-- Vape UI Library - usage example
-- ============================================================

-- lib:Window(title, accentColor, closeKeybind)
--   Creates the window. accentColor tints toggles/sliders/etc.
--   closeKeybind (optional, defaults to RightControl) hides/shows
--   the whole UI when pressed. Returns "win", used to make tabs.
local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/nondevelopers/Vape-UiLibrary/main/source.lua"))()

local win = lib:Window("Vape Ui Library PREVIEW", Color3.fromRGB(44, 120, 224), Enum.KeyCode.RightControl)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- win:Tab(title, icon)
--   Adds a tab to the sidebar. Returns "tab", used to add elements
--   to that tab. Call win:Tab(...) again for more tabs. icon
--   (optional) is a Lucide icon name (e.g. "settings", "home",
--   "sword") - see the embedded LucideIcons table in the library
--   for the full list of ~800 names. You can also pass a raw
--   rbxassetid://, rbxthumb://, or http(s) image link instead of a
--   name if you want a custom icon.
local tab = win:Tab("Tab 1", "layout-grid")

-- tab:Paragraph(title, text)
--   A card with a bold title and a wrapped body of text below it.
tab:Paragraph(
    "About",
    "This is an example UI built with the Vape UI Library. Every element on this page is just here to show what it looks like and how to call it."
)

-- tab:Paragraph(title, text, avatar)
--   Same as above, but avatar (a userId number or a username string)
--   adds a circular avatar thumbnail on the left. Here we use the
--   local player's own info to build the body text.
tab:Paragraph(
    "Player Info",
    string.format("display: %s\nuser: %s\nuserid: %s", LocalPlayer.DisplayName, LocalPlayer.Name, LocalPlayer.UserId),
    LocalPlayer.UserId
)

-- tab:Section(text)
--   A lightweight header used to visually group the elements below
--   it - no background box, just bold text tinted with the window's
--   accent color, with a small gap above it (skipped if it's the
--   first thing in the tab). Returns an object with :Set(newText)
--   if you want to rename it later.
tab:Section("Buttons")

-- tab:Button(title, callback, hasSettings)
--   A simple clickable button; callback runs on click.
--   hasSettings (optional, true/false) adds a "..." to the button -
--   right-click it (PC) or tap the dots (mobile) to open a small
--   panel below it. Button returns an object with :Label(text) to
--   add rows to that panel.
tab:Button("Button", function()
    lib:Notification("Notification", "Hello!", "Hi!")
end)

local button2 = tab:Button("Button 2", function()
    print("Button 2 pressed")
end, true)

button2:Label("Setting 1")
button2:Label("Setting 2")
button2:Label("Setting 3")

tab:Section("Controls")

-- tab:Toggle(title, default, callback)
--   An on/off switch. default is the starting state (true/false).
--   callback fires with the new state every time it's flipped.
tab:Toggle("Toggle", false, function(t)
    print(t)
end)

-- tab:Slider(title, min, max, default, callback)
--   A draggable number slider. callback fires with the current
--   value while dragging.
tab:Slider("Slider", 0, 100, 30, function(t)
    print(t)
end)

-- tab:Dropdown(title, {options...}, callback)
--   A collapsible list of string options. callback fires with the
--   option that was clicked.
tab:Dropdown("Dropdown", {"Option 1", "Option 2", "Option 3", "Option 4", "Option 5"}, function(t)
    print(t)
end)

-- tab:Colorpicker(title, defaultColor, callback)
--   A hue/saturation/value color picker. callback fires with the
--   chosen Color3 whenever it changes.
tab:Colorpicker("Colorpicker", Color3.fromRGB(255, 0, 0), function(t)
    print(t)
end)

tab:Section("Text & Binds")

-- tab:Textbox(title, clearOnFocus, callback)
--   A single-line text input. clearOnFocus (true/false) wipes the
--   box when clicked. callback fires with the typed text on enter.
tab:Textbox("Textbox", true, function(t)
    print(t)
end)

-- tab:Bind(title, defaultKeycode, callback)
--   A rebindable keybind - click it, then press a key to change it.
--   callback fires (no arguments) whenever that key is pressed.
tab:Bind("Bind", Enum.KeyCode.RightShift, function()
    print("Pressed!")
end)

-- tab:Label(text)
--   Plain, non-interactive text - useful for section headers or notes.
tab:Label("Label")

-- ============================================================
-- Settings tab - re-theme the UI live, and a "Fully Close" button
-- that removes the UI from the game entirely (not just hides it).
-- ============================================================
local settings = win:Tab("Settings", "settings")

settings:Section("Appearance")

-- tab:Colorpicker(...) + lib:ChangePresetColor(color)
--   Changes the accent color used by toggles/sliders/tab indicators/
--   etc. across the whole window, live.
settings:Colorpicker("Change UI Color", Color3.fromRGB(44, 120, 224), function(t)
    lib:ChangePresetColor(Color3.fromRGB(t.R * 255, t.G * 255, t.B * 255))
end)

settings:Section("Danger Zone")

-- lib:Destroy()
--   Tears down the entire UI - the ScreenGui and everything inside
--   it (the panel, every tab, notifications, the mobile toggle
--   button). Use this for a "Fully Close" button: unlike the X
--   button or the closeKeybind (which just hide the panel and can
--   reopen it), Destroy() can't be undone from inside the script -
--   you'd need to loadstring the library again to bring the UI
--   back.
settings:Button("Fully Close", function()
    lib:Destroy()
end)
