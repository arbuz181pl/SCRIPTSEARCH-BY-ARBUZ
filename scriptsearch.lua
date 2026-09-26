--//==================================================
--// SCRIPTS BY ARBUZ - Launcher
--//==================================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local MarketplaceService = game:GetService("MarketplaceService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

--==================================================
-- MM2 GAME IDS
--==================================================

local MM2_PLACE_IDS = {
	[142823291] = true,        -- Murder Mystery 2 (main game)
	[121787682648572] = true,  -- reserved server variant
}

--==================================================
-- NOTIFICATION UTILITY
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
-- GAME CHECK (safe, callable later)
--==================================================

local function isInMM2()
	-- Fast path: check PlaceId
	if MM2_PLACE_IDS[game.PlaceId] then
		return true
	end

	-- Slow path: check game name (wrapped so it can't crash)
	local ok, result = pcall(function()
		return MarketplaceService:GetProductInfo(game.PlaceId).Name
	end)

	if ok and result and string.find(string.lower(result), "murder mystery 2", 1, true) then
		return true
	end

	return false
end

--==================================================
-- CLEANUP
--==================================================

local existing = playerGui:FindFirstChild("ScriptsByArbuz")
if existing then existing:Destroy() end

--==================================================
-- GUI
--==================================================

local gui = Instance.new("ScreenGui")
gui.Name = "ScriptsByArbuz"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.IgnoreGuiInset = false
gui.Enabled = true
gui.DisplayOrder = 100
gui.Parent = playerGui

--==================================================
-- MAIN FRAME
--==================================================

local frame = Instance.new("Frame")
frame.Name = "Main"
frame.Size = UDim2.fromOffset(280, 330)
frame.Position = UDim2.new(0.5, -140, 0.5, -165)
frame.BackgroundColor3 = Color3.fromRGB(22, 23, 28)
frame.BorderSizePixel = 0
frame.Visible = true
frame.Active = true
frame.Parent = gui

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 12)
frameCorner.Parent = frame

local frameStroke = Instance.new("UIStroke")
frameStroke.Color = Color3.fromRGB(55, 57, 65)
frameStroke.Thickness = 1
frameStroke.Parent = frame

--==================================================
-- HEADER
--==================================================

local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 48)
header.BackgroundColor3 = Color3.fromRGB(29, 30, 37)
header.BorderSizePixel = 0
header.Active = true
header.Parent = frame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 12)
headerCorner.Parent = header

--==================================================
-- TITLE
--==================================================

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, -50, 1, 0)
title.Position = UDim2.fromOffset(10, 0)
title.BackgroundTransparency = 1
title.Text = "SCRIPTS BY ARBUZ"
title.TextColor3 = Color3.fromRGB(245, 245, 250)
title.TextSize = 13
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextYAlignment = Enum.TextYAlignment.Center
title.ZIndex = 2
title.Parent = header

--==================================================
-- MINIMIZE BUTTON
--==================================================

local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "Minimize"
minimizeButton.Size = UDim2.fromOffset(30, 30)
minimizeButton.Position = UDim2.new(1, -35, 0.5, -15)
minimizeButton.BackgroundColor3 = Color3.fromRGB(42, 44, 52)
minimizeButton.Text = "-"
minimizeButton.TextColor3 = Color3.new(1, 1, 1)
minimizeButton.TextSize = 17
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.BorderSizePixel = 0
minimizeButton.AutoButtonColor = false
minimizeButton.Active = true
minimizeButton.ZIndex = 5
minimizeButton.Parent = header

local minimizeCorner = Instance.new("UICorner")
minimizeCorner.CornerRadius = UDim.new(0, 7)
minimizeCorner.Parent = minimizeButton

--==================================================
-- CONTENT
--==================================================

local content = Instance.new("ScrollingFrame")
content.Name = "Content"
content.Size = UDim2.new(1, -20, 1, -58)
content.Position = UDim2.fromOffset(10, 53)
content.BackgroundTransparency = 1
content.BorderSizePixel = 0
content.ScrollBarThickness = 5
content.ScrollBarImageColor3 = Color3.fromRGB(75, 77, 85)
content.CanvasSize = UDim2.fromOffset(0, 0)
content.AutomaticCanvasSize = Enum.AutomaticSize.Y
content.ScrollingDirection = Enum.ScrollingDirection.Y
content.Parent = frame

local contentLayout = Instance.new("UIListLayout")
contentLayout.Padding = UDim.new(0, 6)
contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
contentLayout.Parent = content

local currentLayoutOrder = 0
local function getLayoutOrder()
	currentLayoutOrder = currentLayoutOrder + 1
	return currentLayoutOrder
end

--==================================================
-- SEARCH BAR
--==================================================

local searchBox = Instance.new("TextBox")
searchBox.Name = "SearchBox"
searchBox.Size = UDim2.new(1, 0, 0, 36)
searchBox.BackgroundColor3 = Color3.fromRGB(34, 36, 43)
searchBox.BorderSizePixel = 0
searchBox.Text = ""
searchBox.PlaceholderText = "Search scripts..."
searchBox.PlaceholderColor3 = Color3.fromRGB(150, 153, 165)
searchBox.TextColor3 = Color3.fromRGB(230, 230, 235)
searchBox.TextSize = 13
searchBox.Font = Enum.Font.GothamSemibold
searchBox.ClearTextOnFocus = false
searchBox.LayoutOrder = getLayoutOrder()
searchBox.Parent = content

local searchCorner = Instance.new("UICorner")
searchCorner.CornerRadius = UDim.new(0, 8)
searchCorner.Parent = searchBox

local searchPadding = Instance.new("UIPadding")
searchPadding.PaddingLeft = UDim.new(0, 10)
searchPadding.PaddingRight = UDim.new(0, 10)
searchPadding.Parent = searchBox

--==================================================
-- SCRIPT LIST
--==================================================

local scriptButtons = {}

local function registerScriptButton(name, button)
	table.insert(scriptButtons, { Name = name, Button = button })
end

--==================================================
-- MM2 SCRIPT BUTTON
--==================================================

local mm2Button = Instance.new("TextButton")
mm2Button.Name = "MM2"
mm2Button.Size = UDim2.new(1, 0, 0, 44)
mm2Button.BackgroundColor3 = Color3.fromRGB(34, 36, 43)
mm2Button.BorderSizePixel = 0
mm2Button.Text = "MM2"
mm2Button.TextColor3 = Color3.fromRGB(230, 230, 235)
mm2Button.TextSize = 14
mm2Button.Font = Enum.Font.GothamBold
mm2Button.AutoButtonColor = false
mm2Button.LayoutOrder = getLayoutOrder()
mm2Button.Parent = content

local mm2Corner = Instance.new("UICorner")
mm2Corner.CornerRadius = UDim.new(0, 8)
mm2Corner.Parent = mm2Button

local mm2Indicator = Instance.new("Frame")
mm2Indicator.Name = "Indicator"
mm2Indicator.Size = UDim2.fromOffset(5, 24)
mm2Indicator.Position = UDim2.fromOffset(8, 10)
mm2Indicator.BackgroundColor3 = Color3.fromRGB(230, 55, 55)
mm2Indicator.BorderSizePixel = 0
mm2Indicator.Parent = mm2Button

local mm2IndicatorCorner = Instance.new("UICorner")
mm2IndicatorCorner.CornerRadius = UDim.new(1, 0)
mm2IndicatorCorner.Parent = mm2Indicator

local mm2SubLabel = Instance.new("TextLabel")
mm2SubLabel.Name = "SubLabel"
mm2SubLabel.Size = UDim2.new(1, -30, 0, 14)
mm2SubLabel.Position = UDim2.new(0, 22, 1, -16)
mm2SubLabel.BackgroundTransparency = 1
mm2SubLabel.Text = "Murder Mystery 2 only"
mm2SubLabel.TextColor3 = Color3.fromRGB(150, 153, 165)
mm2SubLabel.TextSize = 10
mm2SubLabel.Font = Enum.Font.GothamBold
mm2SubLabel.TextXAlignment = Enum.TextXAlignment.Left
mm2SubLabel.ZIndex = 3
mm2SubLabel.Parent = mm2Button

mm2Button.MouseEnter:Connect(function()
	mm2Button.BackgroundColor3 = Color3.fromRGB(45, 47, 56)
end)

mm2Button.MouseLeave:Connect(function()
	mm2Button.BackgroundColor3 = Color3.fromRGB(34, 36, 43)
end)

--==================================================
-- MM2 CLICK HANDLER
--==================================================

local function resetMm2Button()
	mm2Button.Text = "MM2"
	mm2Button.TextColor3 = Color3.fromRGB(230, 230, 235)
end

mm2Button.MouseButton1Click:Connect(function()
	if not isInMM2() then
		mm2Button.Text = "Not in MM2"
		mm2Button.TextColor3 = Color3.fromRGB(255, 100, 100)
		sendNotification("Scripts by Arbuz", "This script only works in Murder Mystery 2!")
		task.wait(2)
		resetMm2Button()
		return
	end

	mm2Button.Text = "Loading..."
	mm2Button.TextColor3 = Color3.fromRGB(255, 205, 50)

	local success, err = pcall(function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/arbuz181pl/MM2-MENU-BY-ARBUZ/refs/heads/main/MM2MENU.lua"))()
	end)

	if success then
		resetMm2Button()
	else
		mm2Button.Text = "Error"
		mm2Button.TextColor3 = Color3.fromRGB(255, 100, 100)
		warn("[Scripts by Arbuz] Failed to load MM2:", err)
		sendNotification("Scripts by Arbuz", "Failed to load MM2 script. Check console (F9).")
		task.wait(2)
		resetMm2Button()
	end
end)

registerScriptButton("MM2", mm2Button)

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
-- DRAG MENU
--==================================================

local dragging = false
local dragStart
local dragStartPosition

header.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		dragStartPosition = frame.Position
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if not dragging then return end
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(
			dragStartPosition.X.Scale, dragStartPosition.X.Offset + delta.X,
			dragStartPosition.Y.Scale, dragStartPosition.Y.Offset + delta.Y
		)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)

--==================================================
-- MINIMIZE
--==================================================

local minimized = false

minimizeButton.MouseButton1Click:Connect(function()
	minimized = not minimized
	if minimized then
		content.Visible = false
		frame.Size = UDim2.fromOffset(280, 48)
		minimizeButton.Text = "+"
	else
		content.Visible = true
		frame.Size = UDim2.fromOffset(280, 330)
		minimizeButton.Text = "-"
	end
end)
