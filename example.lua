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

-- win:Tab(title)
--   Adds a tab to the sidebar. Returns "tab", used to add elements
--   to that tab. Call win:Tab(...) again for more tabs.
local tab = win:Tab("Tab 1")

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

tab:Section("Paragraphs")

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

-- ============================================================
-- Movement examples - speed, jump power, infinite jump, noclip,
-- fly. All client-side Humanoid/character tweaks; nothing here
-- reads or touches other players.
-- ============================================================
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local function GetHumanoid()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    return character:WaitForChild("Humanoid")
end

local movement = win:Tab("Movement")

movement:Section("Speed & Jump")

-- Speed --------------------------------------------------------
local DEFAULT_WALKSPEED = 16
local speedEnabled = false
local speedAmount = 50

movement:Toggle("Speed", false, function(state)
    speedEnabled = state
    GetHumanoid().WalkSpeed = state and speedAmount or DEFAULT_WALKSPEED
end)

movement:Slider("Speed Amount", 16, 200, speedAmount, function(value)
    speedAmount = value
    if speedEnabled then
        GetHumanoid().WalkSpeed = value
    end
end)

-- Jump power -----------------------------------------------------
local DEFAULT_JUMPPOWER = 50
local jumpEnabled = false
local jumpAmount = 100

movement:Toggle("Jump Power", false, function(state)
    jumpEnabled = state
    GetHumanoid().JumpPower = state and jumpAmount or DEFAULT_JUMPPOWER
end)

movement:Slider("Jump Amount", 50, 250, jumpAmount, function(value)
    jumpAmount = value
    if jumpEnabled then
        GetHumanoid().JumpPower = value
    end
end)

-- Infinite jump ----------------------------------------------------
local infiniteJumpEnabled = false
local infiniteJumpConnection

movement:Toggle("Infinite Jump", false, function(state)
    infiniteJumpEnabled = state
    if infiniteJumpConnection then
        infiniteJumpConnection:Disconnect()
        infiniteJumpConnection = nil
    end
    if state then
        infiniteJumpConnection = UserInputService.JumpRequest:Connect(function()
            GetHumanoid():ChangeState(Enum.HumanoidStateType.Jumping)
        end)
    end
end)

-- Noclip -------------------------------------------------------------
local noclipEnabled = false
local noclipConnection

local function SetCharacterCollisions(canCollide)
    local character = LocalPlayer.Character
    if not character then
        return
    end
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = canCollide
        end
    end
end

movement:Section("Fly & Noclip")

movement:Toggle("Noclip", false, function(state)
    noclipEnabled = state
    if noclipConnection then
        noclipConnection:Disconnect()
        noclipConnection = nil
    end
    if state then
        noclipConnection = RunService.Stepped:Connect(function()
            SetCharacterCollisions(false)
        end)
    else
        SetCharacterCollisions(true)
    end
end)

-- Fly ------------------------------------------------------------------
local flyEnabled = false
local flySpeed = 50
local flyVelocity, flyGyro, flyConnection
local heldKeys = {}

UserInputService.InputBegan:Connect(function(input, processed)
    if not processed then
        heldKeys[input.KeyCode] = true
    end
end)
UserInputService.InputEnded:Connect(function(input)
    heldKeys[input.KeyCode] = nil
end)

local function StartFly()
    local humanoid = GetHumanoid()
    local hrp = humanoid.Parent:WaitForChild("HumanoidRootPart")

    flyVelocity = Instance.new("BodyVelocity")
    flyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    flyVelocity.Velocity = Vector3.new(0, 0, 0)
    flyVelocity.Parent = hrp

    flyGyro = Instance.new("BodyGyro")
    flyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    flyGyro.P = 10000
    flyGyro.CFrame = hrp.CFrame
    flyGyro.Parent = hrp

    humanoid.PlatformStand = true

    flyConnection = RunService.RenderStepped:Connect(function()
        local camCFrame = workspace.CurrentCamera.CFrame
        local direction = Vector3.new(0, 0, 0)

        if heldKeys[Enum.KeyCode.W] then
            direction = direction + camCFrame.LookVector
        end
        if heldKeys[Enum.KeyCode.S] then
            direction = direction - camCFrame.LookVector
        end
        if heldKeys[Enum.KeyCode.A] then
            direction = direction - camCFrame.RightVector
        end
        if heldKeys[Enum.KeyCode.D] then
            direction = direction + camCFrame.RightVector
        end
        if heldKeys[Enum.KeyCode.Space] then
            direction = direction + Vector3.new(0, 1, 0)
        end
        if heldKeys[Enum.KeyCode.LeftControl] then
            direction = direction - Vector3.new(0, 1, 0)
        end

        if direction.Magnitude > 0 then
            direction = direction.Unit
        end

        flyVelocity.Velocity = direction * flySpeed
        flyGyro.CFrame = camCFrame
    end)
end

local function StopFly()
    if flyConnection then
        flyConnection:Disconnect()
        flyConnection = nil
    end
    if flyVelocity then
        flyVelocity:Destroy()
        flyVelocity = nil
    end
    if flyGyro then
        flyGyro:Destroy()
        flyGyro = nil
    end
    local character = LocalPlayer.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.PlatformStand = false
    end
end

movement:Toggle("Fly", false, function(state)
    flyEnabled = state
    if state then
        StartFly()
    else
        StopFly()
    end
end)

movement:Slider("Fly Speed", 10, 200, flySpeed, function(value)
    flySpeed = value
end)

-- Re-apply everything after respawning, since a fresh character/Humanoid
-- resets to defaults and drops any BodyVelocity/BodyGyro from Fly.
LocalPlayer.CharacterAdded:Connect(function(character)
    local humanoid = character:WaitForChild("Humanoid")
    humanoid.WalkSpeed = speedEnabled and speedAmount or DEFAULT_WALKSPEED
    humanoid.JumpPower = jumpEnabled and jumpAmount or DEFAULT_JUMPPOWER
    if noclipEnabled then
        SetCharacterCollisions(false)
    end
    if flyEnabled then
        StartFly()
    end
end)

-- ============================================================
-- Settings tab - re-theme the UI live, and a "Fully Close" button
-- that removes the UI from the game entirely (not just hides it).
-- ============================================================
local settings = win:Tab("Settings")

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
