--//==================================================
--// SCRIPTS BY ARBUZ - Launcher
--// Menu by Arbuz theme
--//==================================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local MarketplaceService = game:GetService("MarketplaceService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local RAINBOW_SPEED = 0.25

-- Mobile scale (same as MM2 menu)
local IS_MOBILE = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local MS = IS_MOBILE and 0.68 or 1
local function mn(n) return math.floor(n * MS + 0.5) end
local function msz(x, y) return UDim2.fromOffset(mn(x), mn(y)) end
local function mpos(x, y) return UDim2.fromOffset(mn(x), mn(y)) end

--==================================================
-- MM2 PLACE IDS
--==================================================

local MM2_PLACE_IDS = {
	[142823291] = true,
	[121787682648572] = true,
}

--==================================================
-- SCRIPT URLS
--==================================================

local SCRIPT_URLS = {
	MM2 = "https://raw.githubusercontent.com/arbuz181pl/MM2-MENU-BY-ARBUZ/refs/heads/main/MM2MENU.lua",
	DEX = "https://raw.githubusercontent.com/arbuz181pl/dex/refs/heads/main/dex.lua",
}

--==================================================
-- NOTIFICATION
--==================================================

local function sendNotification(title, text)
	pcall(function()
		StarterGui:SetCore("SendNotification", {
			Title = title,
			Text = text,
			Duration = 5
		})
	end)
end

--==================================================
-- GAME CHECK
--==================================================

local function isInMM2()
	if MM2_PLACE_IDS[game.PlaceId] then
		return true, "PlaceId matched"
	end
	local ok, result = pcall(function()
		return MarketplaceService:GetProductInfo(game.PlaceId).Name
	end)
	if ok and result then
		if string.find(string.lower(result), "murder mystery 2", 1, true) then
			return true, "Name matched"
		end
		return false, "Current game: " .. tostring(result)
	end
	return false, "Could not verify game name"
end

--==================================================
-- CLEANUP
--==================================================

for _, name in ipairs({ "ScriptsByArbuz", "MM2MenuByArbuz" }) do
	local existing = playerGui:FindFirstChild(name)
	if existing then existing:Destroy() end
end

--==================================================
-- GUI
--==================================================

local gui = Instance.new("ScreenGui")
gui.Name = "ScriptsByArbuz"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 100
gui.Parent = playerGui

-- Main frame
local frame = Instance.new("Frame")
frame.Name = "Main"
frame.Size = msz(320, 400)
frame.Position = UDim2.new(0.5, -mn(160), 0.5, -mn(200))
frame.BackgroundColor3 = Color3.fromRGB(22, 23, 28)
frame.BorderSizePixel = 0
frame.Active = true
frame.Parent = gui
do
	local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 12) c.Parent = frame
end

local frameStroke = Instance.new("UIStroke")
frameStroke.Color = Color3.fromRGB(55, 57, 65)
frameStroke.Thickness = 1
frameStroke.Parent = frame

-- Header
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, mn(44))
header.BackgroundColor3 = Color3.fromRGB(29, 30, 37)
header.BorderSizePixel = 0
header.Active = true
header.Parent = frame
do local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 12) c.Parent = header end

-- Title with rainbow gradient
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -mn(120), 1, 0)
title.Position = mpos(10, 0)
title.BackgroundTransparency = 1
title.Text = "SCRIPTS BY ARBUZ"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = mn(13)
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextYAlignment = Enum.TextYAlignment.Center
title.ZIndex = 2
title.Parent = header

local titleGradient = Instance.new("UIGradient")
titleGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 90, 90)),
	ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 220, 90)),
	ColorSequenceKeypoint.new(0.4, Color3.fromRGB(90, 255, 120)),
	ColorSequenceKeypoint.new(0.6, Color3.fromRGB(90, 200, 255)),
	ColorSequenceKeypoint.new(0.8, Color3.fromRGB(210, 110, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 90, 90)),
})
titleGradient.Parent = title

-- Close button
local closeButton = Instance.new("TextButton")
closeButton.Name = "Close"
closeButton.Size = msz(28, 28)
closeButton.Position = UDim2.new(1, -mn(98), 0.5, -mn(14))
closeButton.BackgroundColor3 = Color3.fromRGB(42, 44, 52)
closeButton.Text = "X"
closeButton.TextSize = mn(15)
closeButton.TextColor3 = Color3.fromRGB(255, 200, 200)
closeButton.Font = Enum.Font.GothamBold
closeButton.BorderSizePixel = 0
closeButton.AutoButtonColor = false
closeButton.ZIndex = 5
closeButton.Parent = header
do local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 7) c.Parent = closeButton end

-- Lock button
local lockButton = Instance.new("TextButton")
lockButton.Name = "Lock"
lockButton.Size = msz(28, 28)
lockButton.Position = UDim2.new(1, -mn(66), 0.5, -mn(14))
lockButton.BackgroundColor3 = Color3.fromRGB(42, 44, 52)
lockButton.Text = "🔓"
lockButton.TextSize = mn(13)
lockButton.TextColor3 = Color3.new(1, 1, 1)
lockButton.Font = Enum.Font.GothamBold
lockButton.BorderSizePixel = 0
lockButton.AutoButtonColor = false
lockButton.ZIndex = 5
lockButton.Parent = header
do local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 7) c.Parent = lockButton end

-- Minimize button
local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "Minimize"
minimizeButton.Size = msz(28, 28)
minimizeButton.Position = UDim2.new(1, -mn(34), 0.5, -mn(14))
minimizeButton.BackgroundColor3 = Color3.fromRGB(42, 44, 52)
minimizeButton.Text = "-"
minimizeButton.TextColor3 = Color3.new(1, 1, 1)
minimizeButton.TextSize = mn(16)
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.BorderSizePixel = 0
minimizeButton.AutoButtonColor = false
minimizeButton.ZIndex = 5
minimizeButton.Parent = header
do local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 7) c.Parent = minimizeButton end

-- Resize handle
local resizeHandle = Instance.new("TextButton")
resizeHandle.Name = "ResizeHandle"
resizeHandle.Size = msz(16, 16)
resizeHandle.Position = UDim2.new(1, -mn(16), 1, -mn(16))
resizeHandle.BackgroundColor3 = Color3.fromRGB(55, 57, 65)
resizeHandle.BorderSizePixel = 0
resizeHandle.Text = ""
resizeHandle.AutoButtonColor = false
resizeHandle.ZIndex = 30
resizeHandle.Parent = frame
do local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 4) c.Parent = resizeHandle end

-- Reopen button
local reopenButton = Instance.new("TextButton")
reopenButton.Name = "Reopen"
reopenButton.Size = msz(50, 50)
reopenButton.Position = UDim2.new(0, mn(15), 0.5, -mn(25))
reopenButton.BackgroundColor3 = Color3.fromRGB(29, 30, 37)
reopenButton.BorderSizePixel = 0
reopenButton.Text = "ARB"
reopenButton.TextColor3 = Color3.fromRGB(245, 245, 250)
reopenButton.TextSize = mn(13)
reopenButton.Font = Enum.Font.GothamBold
reopenButton.AutoButtonColor = false
reopenButton.Visible = false
reopenButton.ZIndex = 50
reopenButton.Parent = gui
do local c = Instance.new("UICorner") c.CornerRadius = UDim.new(1, 0) c.Parent = reopenButton end

local reopenStroke = Instance.new("UIStroke")
reopenStroke.Color = Color3.fromRGB(80, 82, 90)
reopenStroke.Thickness = 2
reopenStroke.Parent = reopenButton

-- Content
local content = Instance.new("ScrollingFrame")
content.Name = "Content"
content.Size = UDim2.new(1, -mn(20), 1, -mn(58))
content.Position = mpos(10, 50)
content.BackgroundTransparency = 1
content.BorderSizePixel = 0
content.ScrollBarThickness = 4
content.ScrollBarImageColor3 = Color3.fromRGB(75, 77, 85)
content.CanvasSize = UDim2.fromOffset(0, 0)
content.AutomaticCanvasSize = Enum.AutomaticSize.Y
content.ScrollingDirection = Enum.ScrollingDirection.Y
content.Parent = frame

local contentLayout = Instance.new("UIListLayout")
contentLayout.Padding = UDim.new(0, 3)
contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
contentLayout.Parent = content

local currentLayoutOrder = 0
local function getLayoutOrder()
	currentLayoutOrder = currentLayoutOrder + 1
	return currentLayoutOrder
end

--==================================================
-- HELPERS
--==================================================

local function createSectionTitle(text)
	local label = Instance.new("TextLabel")
	label.Name = text .. "Header"
	label.Size = UDim2.new(1, 0, 0, mn(14))
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = Color3.fromRGB(150, 153, 165)
	label.TextSize = mn(11)
	label.Font = Enum.Font.GothamBold
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.LayoutOrder = getLayoutOrder()
	label.Parent = content
	return label
end

local function createScriptButton(name, text)
	local button = Instance.new("TextButton")
	button.Name = name
	button.Size = UDim2.new(1, 0, 0, mn(42))
	button.BackgroundColor3 = Color3.fromRGB(34, 36, 43)
	button.BorderSizePixel = 0
	button.Text = ""
	button.AutoButtonColor = false
	button.LayoutOrder = getLayoutOrder()
	button.Parent = content
	do local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 8) c.Parent = button end

	local indicator = Instance.new("Frame")
	indicator.Name = "Indicator"
	indicator.Size = msz(5, 22)
	indicator.Position = mpos(7, 10)
	indicator.BackgroundColor3 = Color3.fromRGB(80, 82, 90)
	indicator.BorderSizePixel = 0
	indicator.Parent = button
	do local c = Instance.new("UICorner") c.CornerRadius = UDim.new(1, 0) c.Parent = indicator end

	local nameLabel = Instance.new("TextLabel")
	nameLabel.Name = "NameLabel"
	nameLabel.Size = UDim2.new(1, -mn(30), 0, mn(16))
	nameLabel.Position = mpos(22, 5)
	nameLabel.BackgroundTransparency = 1
	nameLabel.Text = text
	nameLabel.TextColor3 = Color3.fromRGB(230, 230, 235)
	nameLabel.TextSize = mn(12)
	nameLabel.Font = Enum.Font.GothamSemibold
	nameLabel.TextXAlignment = Enum.TextXAlignment.Left
	nameLabel.TextYAlignment = Enum.TextYAlignment.Center
	nameLabel.ZIndex = 3
	nameLabel.Parent = button

	local subLabel = Instance.new("TextLabel")
	subLabel.Name = "SubLabel"
	subLabel.Size = UDim2.new(1, -mn(30), 0, mn(12))
	subLabel.Position = mpos(22, 22)
	subLabel.BackgroundTransparency = 1
	subLabel.Text = ""
	subLabel.TextColor3 = Color3.fromRGB(150, 153, 165)
	subLabel.TextSize = mn(10)
	subLabel.Font = Enum.Font.Gotham
	subLabel.TextXAlignment = Enum.TextXAlignment.Left
	subLabel.TextYAlignment = Enum.TextYAlignment.Center
	subLabel.ZIndex = 3
	subLabel.Parent = button

	button.MouseEnter:Connect(function()
		button.BackgroundColor3 = Color3.fromRGB(45, 47, 56)
	end)

	button.MouseLeave:Connect(function()
		button.BackgroundColor3 = Color3.fromRGB(34, 36, 43)
	end)

	return button, indicator, nameLabel, subLabel
end

--==================================================
-- SEARCH BAR
--==================================================

local searchBox = Instance.new("TextBox")
searchBox.Name = "SearchBox"
searchBox.Size = UDim2.new(1, 0, 0, mn(28))
searchBox.BackgroundColor3 = Color3.fromRGB(34, 36, 43)
searchBox.BorderSizePixel = 0
searchBox.Text = ""
searchBox.PlaceholderText = "Search scripts..."
searchBox.PlaceholderColor3 = Color3.fromRGB(120, 122, 130)
searchBox.TextColor3 = Color3.fromRGB(230, 230, 235)
searchBox.TextSize = mn(12)
searchBox.Font = Enum.Font.GothamSemibold
searchBox.ClearTextOnFocus = false
searchBox.TextXAlignment = Enum.TextXAlignment.Left
searchBox.LayoutOrder = getLayoutOrder()
searchBox.Parent = content
do
	local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 8) c.Parent = searchBox
	local p = Instance.new("UIPadding") p.PaddingLeft = UDim.new(0, 8) p.Parent = searchBox
end

--==================================================
-- SCRIPT LIST
--==================================================

createSectionTitle("SCRIPTS")

local scriptButtons = {}

local function registerScriptButton(name, button)
	table.insert(scriptButtons, { Name = name, Button = button })
end

--==================================================
-- CLOSE / REOPEN
--==================================================

local menuVisible = true

local function showMenu()
	menuVisible = true
	frame.Visible = true
	reopenButton.Visible = false
end

local function hideMenu()
	menuVisible = false
	frame.Visible = false
	reopenButton.Visible = true
end

--==================================================
-- MM2 BUTTON
--==================================================

local mm2Button, mm2Indicator, mm2NameLabel, mm2SubLabel = createScriptButton("MM2", "MM2 Menu")
mm2Indicator.BackgroundColor3 = Color3.fromRGB(230, 55, 55)
mm2SubLabel.Text = "Murder Mystery 2 only"

local function resetMm2Button()
	mm2NameLabel.Text = "MM2 Menu"
	mm2NameLabel.TextColor3 = Color3.fromRGB(230, 230, 235)
	mm2Indicator.BackgroundColor3 = Color3.fromRGB(230, 55, 55)
end

mm2Button.MouseButton1Click:Connect(function()
	-- Game check
	local inMM2, reason = isInMM2()
	if not inMM2 then
		mm2NameLabel.Text = "Wrong game"
		mm2NameLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
		mm2Indicator.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
		sendNotification("Scripts by Arbuz", "MM2 only works in Murder Mystery 2.\n" .. tostring(reason))
		warn("[Scripts by Arbuz] Not in MM2 - " .. tostring(reason))
		task.wait(2)
		resetMm2Button()
		return
	end

	if not loadstring then
		sendNotification("Scripts by Arbuz", "Executor does not support loadstring")
		return
	end

	mm2NameLabel.Text = "Loading..."
	mm2NameLabel.TextColor3 = Color3.fromRGB(255, 205, 50)
	mm2Indicator.BackgroundColor3 = Color3.fromRGB(255, 205, 50)

	local url = SCRIPT_URLS.MM2 .. "?v=" .. tick()

	sendNotification("Scripts by Arbuz", "Loading MM2...")

	-- Close launcher before MM2 boots
	gui:Destroy()
	task.wait(0.1)

	task.spawn(function()
		local ok, err = pcall(function()
			loadstring(game:HttpGet(url))()
		end)
		if not ok then
			warn("[Scripts by Arbuz] MM2 runtime error:", err)
			pcall(function()
				StarterGui:SetCore("SendNotification", {
					Title = "Scripts by Arbuz",
					Text = "MM2 crashed. Check F9.",
					Duration = 5
				})
			end)
		end
	end)
end)

registerScriptButton("MM2 Menu", mm2Button)

--==================================================
-- DEX BUTTON
--==================================================

local dexButton, dexIndicator, dexNameLabel, dexSubLabel = createScriptButton("Dex", "DEX Explorer")
dexIndicator.BackgroundColor3 = Color3.fromRGB(80, 200, 120)
dexSubLabel.Text = "Universal script explorer"

dexButton.MouseButton1Click:Connect(function()
	if not loadstring then
		sendNotification("Scripts by Arbuz", "Executor does not support loadstring")
		return
	end

	dexNameLabel.Text = "Loading..."
	dexNameLabel.TextColor3 = Color3.fromRGB(255, 205, 50)
	dexIndicator.BackgroundColor3 = Color3.fromRGB(255, 205, 50)

	local url = SCRIPT_URLS.DEX .. "?v=" .. tick()

	sendNotification("Scripts by Arbuz", "Loading DEX...")

	task.spawn(function()
		local ok, err = pcall(function()
			loadstring(game:HttpGet(url))()
		end)
		if not ok then
			warn("[Scripts by Arbuz] DEX runtime error:", err)
			pcall(function()
				StarterGui:SetCore("SendNotification", {
					Title = "Scripts by Arbuz",
					Text = "DEX crashed. Check F9.",
					Duration = 5
				})
			end)
		end
	end)

	task.wait(2)
	dexNameLabel.Text = "DEX Explorer"
	dexNameLabel.TextColor3 = Color3.fromRGB(230, 230, 235)
	dexIndicator.BackgroundColor3 = Color3.fromRGB(80, 200, 120)
end)

registerScriptButton("DEX Explorer", dexButton)

--==================================================
-- SEARCH FILTER
--==================================================

searchBox:GetPropertyChangedSignal("Text"):Connect(function()
	local query = string.lower(searchBox.Text)
	for _, entry in ipairs(scriptButtons) do
		if entry.Button and entry.Button.Parent then
			local matches = query == "" or string.find(string.lower(entry.Name), query, 1, true)
			entry.Button.Visible = matches
		end
	end
end)

--==================================================
-- DRAG
--==================================================

local guiLocked = false
local dragging = false
local dragStart, dragStartPosition

header.InputBegan:Connect(function(input)
	if guiLocked then return end
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		dragStartPosition = frame.Position
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if not dragging or guiLocked then return end
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		local d = input.Position - dragStart
		frame.Position = UDim2.new(
			dragStartPosition.X.Scale, dragStartPosition.X.Offset + d.X,
			dragStartPosition.Y.Scale, dragStartPosition.Y.Offset + d.Y
		)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)

--==================================================
-- RESIZE
--==================================================

local resizing = false
local resizeStart, resizeStartSize

resizeHandle.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		resizing = true
		resizeStart = input.Position
		resizeStartSize = frame.AbsoluteSize
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if not resizing then return end
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		local d = input.Position - resizeStart
		frame.Size = UDim2.fromOffset(
			math.max(mn(260), resizeStartSize.X + d.X),
			math.max(mn(220), resizeStartSize.Y + d.Y)
		)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		resizing = false
	end
end)

--==================================================
-- LOCK / MINIMIZE / CLOSE / REOPEN
--==================================================

lockButton.MouseButton1Click:Connect(function()
	guiLocked = not guiLocked
	if guiLocked then
		lockButton.Text = "🔒"
		lockButton.BackgroundColor3 = Color3.fromRGB(70, 45, 45)
	else
		lockButton.Text = "🔓"
		lockButton.BackgroundColor3 = Color3.fromRGB(42, 44, 52)
	end
end)

local minimized = false
minimizeButton.MouseButton1Click:Connect(function()
	minimized = not minimized
	if minimized then
		content.Visible = false
		frame.Size = msz(320, 44)
		minimizeButton.Text = "+"
	else
		content.Visible = true
		frame.Size = msz(320, 400)
		minimizeButton.Text = "-"
	end
end)

closeButton.MouseButton1Click:Connect(function()
	hideMenu()
	sendNotification("Scripts by Arbuz", "Launcher closed. Press Right Shift to reopen.")
end)

closeButton.MouseEnter:Connect(function()
	closeButton.BackgroundColor3 = Color3.fromRGB(180, 55, 55)
end)

closeButton.MouseLeave:Connect(function()
	closeButton.BackgroundColor3 = Color3.fromRGB(42, 44, 52)
end)

reopenButton.MouseButton1Click:Connect(function()
	showMenu()
end)

UserInputService.InputBegan:Connect(function(input, processed)
	if processed then return end
	if input.KeyCode == Enum.KeyCode.RightShift then
		if not gui.Parent then return end
		if menuVisible then
			hideMenu()
		else
			showMenu()
		end
	end
end)

-- Reopen drag
local reopenDragging = false
local reopenDragStart, reopenDragStartPosition

reopenButton.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		reopenDragging = true
		reopenDragStart = input.Position
		reopenDragStartPosition = reopenButton.Position
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if not reopenDragging then return end
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		local d = input.Position - reopenDragStart
		reopenButton.Position = UDim2.new(
			reopenDragStartPosition.X.Scale, reopenDragStartPosition.X.Offset + d.X,
			reopenDragStartPosition.Y.Scale, reopenDragStartPosition.Y.Offset + d.Y
		)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		reopenDragging = false
	end
end)

--==================================================
-- RAINBOW ANIMATION
--==================================================

RunService.Heartbeat:Connect(function()
	if not gui.Parent then return end
	local hue = (tick() * RAINBOW_SPEED) % 1
	local color = Color3.fromHSV(hue, 1, 1)
	frameStroke.Color = color
	reopenStroke.Color = color
	titleGradient.Rotation = (tick() * 60) % 360
end)
