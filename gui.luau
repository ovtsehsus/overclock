
DISCORD = "https://discord.gg/rdw5afp3UX"

local V = "0.3.8"

task.wait(1)
local viewportSize = workspace.CurrentCamera.ViewportSize

--\ Configuration
local minWindowSize = UDim2.fromOffset(450, 575)
local maxWindowSizeX = viewportSize.X
local maxWindowSizeY = viewportSize.Y
--/

print(minWindowSize.X, maxWindowSizeX)
print(minWindowSize.Y, maxWindowSizeY)

local wait = task.wait
local clamp = math.clamp
local floor = math.floor
local max = math.max

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

local UserInputService = game.UserInputService
local TweenService = game.TweenService
local ContextActionService = game.ContextActionService

local fontFaces = {
	["Source Sans Pro Regular"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal);
	["Comic Neue Angular Bold"] = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal);
	["Comic Neue Angular Regular"] = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal);
}

--\
local function slider(mover: GuiButton, callback, Xax, Yax, options)
	options = options or {}

	local steps = options.steps or 0
	steps = (steps > 1 and steps or false)
	local useTween = options.useTween or false
	local tweenInfo = options.tweenInfo or TweenInfo.new(0.3)
	local defaultX, defaultY = options.defaultX, options.defaultY

	local isButton1Down = false
	local function mouseDowned(andRisesInstantly)
		local foreAS = mover.AbsoluteSize

		local backAP = mover.Parent.AbsolutePosition
		local backAS = mover.Parent.AbsoluteSize

		local mouseLocation = Vector2.new(mouse.X, mouse.Y) -- UserInputService:GetMouseLocation()

		local xOffset = (mouseLocation.X - backAP.X) / backAS.X - mover.Position.X.Scale
		local yOffset = (mouseLocation.Y - backAP.Y) / backAS.Y - mover.Position.Y.Scale

		local function set(X, Y)
			callback(X or 0, Y or 0)
			local v3 = UDim2.fromScale(X or 0.5, Y or 0.5)
			if useTween then
				TweenService:Create(mover, tweenInfo, {Position = v3}):Play()
			else
				mover.Position = v3
			end
		end

		local lastX, lastY
		local function XY()
			mouseLocation = Vector2.new(mouse.X, mouse.Y) -- UserInputService:GetMouseLocation()
			local X, Y
			if Xax then
				X = clamp((mouseLocation.X - backAP.X) / backAS.X - xOffset, 0, 1)
			end
			if Yax then
				Y = clamp((mouseLocation.Y - backAP.Y)  / backAS.Y - yOffset, 0, 1)
			end
			if steps then
				if Xax then
					X = floor(X * steps) / steps
				end
				if Yax then
					Y = floor(Y * steps) / steps
				end
			end
			if X ~= lastX or Y ~= lastY then
				lastX, lastY = X, Y
			end
			return X, Y
		end

		if andRisesInstantly then
			if defaultX == nil and defaultY == nil then
				set(XY())
			else
				set(defaultX, defaultY)
			end
		else
			while isButton1Down do
				set(XY())
				game["Run Service"].RenderStepped:Wait()
			end
		end
	end

	mouseDowned(true)

	return mover.MouseButton1Down:Connect(function()
		isButton1Down = true

		local connection
		connection = UserInputService.InputEnded:Connect(function(inputObject)
			if inputObject.UserInputState == Enum.UserInputState.End then
				connection:Disconnect()
				isButton1Down = false
			end
		end)

		mouseDowned()
	end)
end

local function roundDown(num, decimalPlaces)
	local mult = 10 ^ decimalPlaces
	return floor(num * mult) / mult
end -- DeepSeek
--/
--\ TODO: UI 0/1
local function createRoot(name)
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = name or tostring(math.random(10^(10-2), 10^(10-1)-1))
	screenGui.Enabled = false
	screenGui.DisplayOrder = 999999999 - 100
	screenGui.IgnoreGuiInset = true
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	return screenGui
end

local function createWindow(title, minWindowSize: UDim2)
	local canvasGroup = Instance.new("CanvasGroup")
	local frame_2 = Instance.new("Frame")
	local tabs = Instance.new("Frame")
	local UIListLayout = Instance.new("UIListLayout")
	local textButton = Instance.new("TextButton")
	local textButton_2 = Instance.new("TextButton")
	local textButton_3 = Instance.new("TextButton")
	local textButton_4 = Instance.new("TextButton")
	local textButton_5 = Instance.new("TextButton")
	local textButton_6 = Instance.new("TextButton")
	local textButton_7 = Instance.new("TextButton")
	local textButton_8 = Instance.new("TextButton")
	local textButton_9 = Instance.new("TextButton")
	local textButton_10 = Instance.new("TextButton")
	local textButton_11 = Instance.new("TextButton")
	local scrollingFrame = Instance.new("ScrollingFrame")
	local UIListLayout_2 = Instance.new("UIListLayout")
	local UIPadding = Instance.new("UIPadding")
	local textButton_12 = Instance.new("TextButton")
	local frame_3 = Instance.new("Frame")
	local UIListLayout_3 = Instance.new("UIListLayout")
	local textButton_13 = Instance.new("TextButton")
	local textButton_14 = Instance.new("TextButton")
	local textLabel = Instance.new("TextLabel")
	local bottom = Instance.new("Frame")
	local resizer = Instance.new("TextButton")
	local textLabel_2 = Instance.new("TextLabel")
	local frame_4 = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")

	canvasGroup.BackgroundColor3 = Color3.fromRGB(25, 26, 31)
	canvasGroup.BorderColor3 = Color3.fromRGB(255, 170, 0)
	canvasGroup.BorderSizePixel = 2
	canvasGroup.Size = minWindowSize

	frame_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	frame_2.BackgroundTransparency = 1
	frame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	frame_2.BorderSizePixel = 0
	frame_2.Position = UDim2.fromOffset(0, 50)
	frame_2.Size = UDim2.new(1, 0, 1, -75)
	frame_2.Parent = canvasGroup

	tabs.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	tabs.BorderColor3 = Color3.fromRGB(0, 0, 0)
	tabs.Name = "Tabs"
	tabs.Position = UDim2.fromOffset(1, 0)
	tabs.Size = UDim2.new(1, -2, 0, 50)
	tabs.Parent = frame_2

	UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Wraps = true
	UIListLayout.HorizontalFlex = Enum.UIFlexAlignment.Fill
	UIListLayout.Parent = tabs

	textButton.AutoButtonColor = false
	textButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	textButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	textButton.BorderMode = Enum.BorderMode.Inset
	textButton.Size = UDim2.fromOffset(100, 25)
	textButton.FontFace = fontFaces["Comic Neue Angular Regular"]
	textButton.Text = ""
	textButton.TextColor3 = Color3.fromRGB(0, 0, 0)
	textButton.TextSize = 18
	textButton.Parent = tabs

	textButton_2.AutoButtonColor = false
	textButton_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	textButton_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	textButton_2.BorderMode = Enum.BorderMode.Inset
	textButton_2.LayoutOrder = 1
	textButton_2.Size = UDim2.fromOffset(100, 25)
	textButton_2.FontFace = fontFaces["Comic Neue Angular Regular"]
	textButton_2.Text = ""
	textButton_2.TextColor3 = Color3.fromRGB(0, 0, 0)
	textButton_2.TextSize = 18
	textButton_2.Parent = tabs

	textButton_3.AutoButtonColor = false
	textButton_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	textButton_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
	textButton_3.BorderMode = Enum.BorderMode.Inset
	textButton_3.LayoutOrder = 2
	textButton_3.Size = UDim2.fromOffset(100, 25)
	textButton_3.FontFace = fontFaces["Comic Neue Angular Regular"]
	textButton_3.Text = ""
	textButton_3.TextColor3 = Color3.fromRGB(0, 0, 0)
	textButton_3.TextSize = 18
	textButton_3.Parent = tabs

	textButton_4.AutoButtonColor = false
	textButton_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	textButton_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
	textButton_4.BorderMode = Enum.BorderMode.Inset
	textButton_4.LayoutOrder = 3
	textButton_4.Size = UDim2.fromOffset(100, 25)
	textButton_4.FontFace = fontFaces["Comic Neue Angular Regular"]
	textButton_4.Text = ""
	textButton_4.TextColor3 = Color3.fromRGB(0, 0, 0)
	textButton_4.TextSize = 18
	textButton_4.Parent = tabs

	textButton_5.AutoButtonColor = false
	textButton_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	textButton_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
	textButton_5.BorderMode = Enum.BorderMode.Inset
	textButton_5.LayoutOrder = 4
	textButton_5.Size = UDim2.fromOffset(100, 25)
	textButton_5.FontFace = fontFaces["Comic Neue Angular Regular"]
	textButton_5.Text = ""
	textButton_5.TextColor3 = Color3.fromRGB(0, 0, 0)
	textButton_5.TextSize = 18
	textButton_5.Parent = tabs

	textButton_6.AutoButtonColor = false
	textButton_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	textButton_6.BorderColor3 = Color3.fromRGB(0, 0, 0)
	textButton_6.BorderMode = Enum.BorderMode.Inset
	textButton_6.LayoutOrder = 5
	textButton_6.Size = UDim2.fromOffset(100, 25)
	textButton_6.FontFace = fontFaces["Comic Neue Angular Regular"]
	textButton_6.Text = ""
	textButton_6.TextColor3 = Color3.fromRGB(0, 0, 0)
	textButton_6.TextSize = 18
	textButton_6.Parent = tabs

	textButton_7.AutoButtonColor = false
	textButton_7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	textButton_7.BorderColor3 = Color3.fromRGB(0, 0, 0)
	textButton_7.BorderMode = Enum.BorderMode.Inset
	textButton_7.LayoutOrder = 6
	textButton_7.Size = UDim2.fromOffset(100, 25)
	textButton_7.FontFace = fontFaces["Comic Neue Angular Regular"]
	textButton_7.Text = ""
	textButton_7.TextColor3 = Color3.fromRGB(0, 0, 0)
	textButton_7.TextSize = 18
	textButton_7.Parent = tabs

	textButton_8.AutoButtonColor = false
	textButton_8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	textButton_8.BorderColor3 = Color3.fromRGB(0, 0, 0)
	textButton_8.BorderMode = Enum.BorderMode.Inset
	textButton_8.LayoutOrder = 7
	textButton_8.Size = UDim2.fromOffset(100, 25)
	textButton_8.FontFace = fontFaces["Comic Neue Angular Regular"]
	textButton_8.Text = ""
	textButton_8.TextColor3 = Color3.fromRGB(0, 0, 0)
	textButton_8.TextSize = 18
	textButton_8.Parent = tabs

	textButton_9.AutoButtonColor = false
	textButton_9.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	textButton_9.BorderColor3 = Color3.fromRGB(0, 0, 0)
	textButton_9.BorderMode = Enum.BorderMode.Inset
	textButton_9.LayoutOrder = 8
	textButton_9.Size = UDim2.fromOffset(100, 25)
	textButton_9.FontFace = fontFaces["Comic Neue Angular Regular"]
	textButton_9.Text = ""
	textButton_9.TextColor3 = Color3.fromRGB(0, 0, 0)
	textButton_9.TextSize = 18
	textButton_9.Parent = tabs

	textButton_10.AutoButtonColor = false
	textButton_10.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	textButton_10.BorderColor3 = Color3.fromRGB(0, 0, 0)
	textButton_10.BorderMode = Enum.BorderMode.Inset
	textButton_10.LayoutOrder = 10
	textButton_10.Size = UDim2.fromOffset(100, 25)
	textButton_10.FontFace = fontFaces["Comic Neue Angular Regular"]
	textButton_10.Text = "Settings"
	textButton_10.TextColor3 = Color3.fromRGB(0, 0, 0)
	textButton_10.TextSize = 18
	textButton_10.Parent = tabs

	textButton_11.AutoButtonColor = false
	textButton_11.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	textButton_11.BorderColor3 = Color3.fromRGB(0, 0, 0)
	textButton_11.BorderMode = Enum.BorderMode.Inset
	textButton_11.LayoutOrder = 9
	textButton_11.Size = UDim2.fromOffset(100, 25)
	textButton_11.FontFace = fontFaces["Comic Neue Angular Regular"]
	textButton_11.Text = ""
	textButton_11.TextColor3 = Color3.fromRGB(0, 0, 0)
	textButton_11.TextSize = 18
	textButton_11.Parent = tabs

	scrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	scrollingFrame.BackgroundTransparency = 1
	scrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	scrollingFrame.BorderSizePixel = 0
	scrollingFrame.Position = UDim2.fromOffset(5, 80)
	scrollingFrame.Size = UDim2.new(1, -10, 1, -85)
	scrollingFrame.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	scrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
	scrollingFrame.ScrollBarThickness = 4
	scrollingFrame.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	scrollingFrame.Parent = frame_2

	UIListLayout_2.Padding = UDim.new(0, 5)
	UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_2.Parent = scrollingFrame

	UIPadding.PaddingRight = UDim.new(0, 10)
	UIPadding.Parent = scrollingFrame

	textButton_12.AutoButtonColor = false
	textButton_12.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	textButton_12.BackgroundTransparency = 1
	textButton_12.BorderColor3 = Color3.fromRGB(0, 0, 0)
	textButton_12.BorderSizePixel = 0
	textButton_12.Name = "Top"
	textButton_12.Size = UDim2.new(1, 0, 0, 25)
	textButton_12.Text = ""
	textButton_12.TextColor3 = Color3.fromRGB(0, 0, 0)
	textButton_12.TextSize = 14
	textButton_12.Parent = canvasGroup

	frame_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	frame_3.BackgroundTransparency = 1
	frame_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
	frame_3.BorderSizePixel = 0
	frame_3.Position = UDim2.fromScale(0.6, 0)
	frame_3.Size = UDim2.fromScale(0.4, 1)
	frame_3.Parent = textButton_12

	UIListLayout_3.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_3.HorizontalAlignment = Enum.HorizontalAlignment.Right
	UIListLayout_3.Parent = frame_3

	textButton_13.BackgroundColor3 = Color3.fromRGB(238, 114, 107)
	textButton_13.BorderColor3 = Color3.fromRGB(0, 0, 0)
	textButton_13.BorderSizePixel = 0
	textButton_13.LayoutOrder = 2
	textButton_13.Name = "Close"
	textButton_13.Position = UDim2.new(1, -25, 0, 0)
	textButton_13.Size = UDim2.fromOffset(25, 25)
	textButton_13.Font = 36
	textButton_13.Text = "x"
	textButton_13.TextColor3 = Color3.fromRGB(0, 0, 0)
	textButton_13.TextSize = 22
	textButton_13.Parent = frame_3

	textButton_14.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	textButton_14.BorderColor3 = Color3.fromRGB(0, 0, 0)
	textButton_14.BorderSizePixel = 0
	textButton_14.LayoutOrder = 1
	textButton_14.Name = "Hide"
	textButton_14.Position = UDim2.new(1, -25, 0, 0)
	textButton_14.Size = UDim2.fromOffset(25, 25)
	textButton_14.Font = 36
	textButton_14.Text = "-"
	textButton_14.TextColor3 = Color3.fromRGB(0, 0, 0)
	textButton_14.TextSize = 22
	textButton_14.Parent = frame_3

	textLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	textLabel.BackgroundTransparency = 1
	textLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	textLabel.BorderSizePixel = 0
	textLabel.Name = "Title"
	textLabel.Position = UDim2.fromOffset(10, 0)
	textLabel.Size = UDim2.new(0.6, -10, 1, 0)
	textLabel.FontFace = fontFaces["Comic Neue Angular Regular"]
	textLabel.Text = "Window"
	textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	textLabel.TextSize = 18
	textLabel.TextXAlignment = Enum.TextXAlignment.Left
	textLabel.Parent = textButton_12

	bottom.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	bottom.BackgroundTransparency = 1
	bottom.BorderColor3 = Color3.fromRGB(0, 0, 0)
	bottom.BorderSizePixel = 0
	bottom.Name = "Bottom"
	bottom.Position = UDim2.new(0, 0, 1, -25)
	bottom.Size = UDim2.new(1, 0, 0, 25)
	bottom.ClipsDescendants = true
	bottom.Parent = canvasGroup

	resizer.AutoButtonColor = false
	resizer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	resizer.BackgroundTransparency = 1
	resizer.BorderColor3 = Color3.fromRGB(0, 0, 0)
	resizer.BorderSizePixel = 0
	resizer.Name = "Resizer"
	resizer.Position = UDim2.new(1, -25, 0, 0)
	resizer.Size = UDim2.new(0, 25, 1, 0)
	resizer.ZIndex = 2
	resizer.Font = 45
	resizer.Text = ""
	resizer.TextColor3 = Color3.fromRGB(0, 0, 0)
	resizer.TextSize = 14
	resizer.Parent = bottom

	textLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	textLabel_2.BackgroundTransparency = 1
	textLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	textLabel_2.BorderSizePixel = 0
	textLabel_2.Position = UDim2.fromOffset(2, 2)
	textLabel_2.Rotation = -135
	textLabel_2.Size = UDim2.fromScale(1, 1)
	textLabel_2.Font = 2
	textLabel_2.Text = ">"
	textLabel_2.TextColor3 = Color3.fromRGB(0, 0, 0)
	textLabel_2.TextSize = 18
	textLabel_2.Parent = resizer

	frame_4.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
	frame_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
	frame_4.BorderSizePixel = 0
	frame_4.Position = UDim2.new(1, -25, 0, 0)
	frame_4.Size = UDim2.fromOffset(50, 50)
	frame_4.Parent = bottom

	UICorner.CornerRadius = UDim.new(0.5, 0)
	UICorner.Parent = frame_4

	do
		local frame = Instance.new("Frame")
		local textBox = Instance.new("TextBox")
		local UIPadding = Instance.new("UIPadding")

		frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		frame.BorderMode = Enum.BorderMode.Inset
		frame.BorderSizePixel = 2
		frame.Name = "Filter"
		frame.Position = UDim2.fromOffset(0, 25)
		frame.Size = UDim2.new(1, 0, 0, 26)

		textBox.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		textBox.BorderColor3 = Color3.fromRGB(25, 26, 31)
		textBox.BorderMode = Enum.BorderMode.Inset
		textBox.BorderSizePixel = 2
		textBox.Position = UDim2.fromScale(0.5, 0)
		textBox.Size = UDim2.fromScale(0.5, 1)
		textBox.FontFace = fontFaces["Comic Neue Angular Regular"]
		textBox.PlaceholderColor3 = Color3.fromRGB(128, 128, 128)
		textBox.PlaceholderText = "Search"
		textBox.Text = ""
		textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
		textBox.TextSize = 18
		textBox.TextXAlignment = Enum.TextXAlignment.Left
		textBox.Parent = frame

		UIPadding.PaddingLeft = UDim.new(0, 5)
		UIPadding.PaddingRight = UDim.new(0, 5)
		UIPadding.Parent = textBox

		frame.Parent = canvasGroup
	end

	return canvasGroup
end

local function createSection()
	local section = Instance.new("Frame")
	local UIListLayout = Instance.new("UIListLayout")
	local UIPadding = Instance.new("UIPadding")

	section.AutomaticSize = Enum.AutomaticSize.Y
	section.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	section.BorderColor3 = Color3.fromRGB(0, 0, 0)
	section.BorderSizePixel = 0
	section.LayoutOrder = 3
	section.Name = "Section"
	section.Size = UDim2.new(1, 0, 0, 40)
	section.ClipsDescendants = true

	UIListLayout.Padding = UDim.new(0, 5)
	UIListLayout.SortOrder = Enum.SortOrder.Name
	UIListLayout.Parent = section

	UIPadding.PaddingBottom = UDim.new(0, 10)
	UIPadding.PaddingLeft = UDim.new(0, 10)
	UIPadding.PaddingRight = UDim.new(0, 10)
	UIPadding.PaddingTop = UDim.new(0, 10)
	UIPadding.Parent = section

	return section
end

local function createGroup(name)
	local group = Instance.new("Frame")
	local UIPadding = Instance.new("UIPadding")
	local textLabel = Instance.new("TextLabel")
	local frame = Instance.new("Frame")
	local UIListLayout = Instance.new("UIListLayout")

	group.AutomaticSize = Enum.AutomaticSize.Y
	group.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	group.BackgroundTransparency = 0.9
	group.BorderColor3 = Color3.fromRGB(0, 0, 0)
	group.BorderSizePixel = 0
	group.LayoutOrder = 1
	group.Name = "Group"
	group.Size = UDim2.new(1, 0, 0, 20)

	UIPadding.PaddingBottom = UDim.new(0, 5)
	UIPadding.PaddingTop = UDim.new(0, 5)
	UIPadding.Parent = group

	textLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	textLabel.BackgroundTransparency = 1
	textLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	textLabel.BorderSizePixel = 0
	textLabel.Position = UDim2.fromOffset(5, 0)
	textLabel.Size = UDim2.new(0.5, -5, 1, 0)
	textLabel.FontFace = fontFaces["Comic Neue Angular Bold"]
	textLabel.Text = name or "Group"
	textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	textLabel.TextSize = 16
	textLabel.TextXAlignment = Enum.TextXAlignment.Left
	textLabel.Parent = group

	frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	frame.BackgroundTransparency = 1
	frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	frame.BorderSizePixel = 0
	frame.Position = UDim2.fromScale(0.5, 0)
	frame.Size = UDim2.new(0.5, -5, 1, 0)
	frame.Parent = group

	UIListLayout.Padding = UDim.new(0, 5)
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
	UIListLayout.Parent = frame

	return group
end

local elementTypes = { -- TODO: Типы элементов
	["Text"] = function(text) -- section title
		local textLabel = Instance.new("TextLabel")
		textLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		textLabel.BackgroundTransparency = 0.9
		textLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		textLabel.BorderSizePixel = 0
		textLabel.LayoutOrder = -1
		textLabel.Name = "Text"
		textLabel.Size = UDim2.new(1, 0, 0, 20)
		textLabel.FontFace = fontFaces["Comic Neue Angular Bold"]
		textLabel.Text = text or "Section"
		textLabel.TextColor3 = Color3.fromRGB(127, 127, 127)
		textLabel.TextSize = 16
		return textLabel
	end,

	["Label"] = function(key, value) -- string r
		value = value or ""
		
		local label = Instance.new("Frame")
		local UIPadding = Instance.new("UIPadding")
		local textLabel = Instance.new("TextLabel")
		local frame = Instance.new("Frame")
		local textBox = Instance.new("TextBox")
		local UICorner = Instance.new("UICorner")

		label.AutomaticSize = Enum.AutomaticSize.Y
		label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		label.BackgroundTransparency = 0.9
		label.BorderColor3 = Color3.fromRGB(0, 0, 0)
		label.BorderSizePixel = 0
		label.Name = "Label"
		label.Size = UDim2.new(1, 0, 0, 20)

		UIPadding.PaddingBottom = UDim.new(0, 5)
		UIPadding.PaddingTop = UDim.new(0, 5)
		UIPadding.Parent = label

		textLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		textLabel.BackgroundTransparency = 1
		textLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		textLabel.BorderSizePixel = 0
		textLabel.Position = UDim2.fromOffset(5, 0)
		textLabel.Size = UDim2.new(0.5, -5, 1, 0)
		textLabel.FontFace = fontFaces["Comic Neue Angular Bold"]
		textLabel.Text = key or "Label"
		textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		textLabel.TextSize = 16
		textLabel.TextXAlignment = Enum.TextXAlignment.Left
		textLabel.Parent = label

		frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		frame.BackgroundTransparency = 1
		frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		frame.BorderSizePixel = 0
		frame.Position = UDim2.fromScale(0.5, 0)
		frame.Size = UDim2.new(0.5, -5, 1, 0)
		frame.Parent = label

		textBox.AutomaticSize = Enum.AutomaticSize.Y
		textBox.BackgroundColor3 = Color3.fromRGB(140, 140, 140)
		textBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
		textBox.BorderSizePixel = 0
		textBox.ClearTextOnFocus = false
		textBox.CursorPosition = -1
		textBox.Size = UDim2.new(1, 0, 0, 20)
		textBox.TextEditable = false
		textBox.FontFace = fontFaces["Comic Neue Angular Bold"]
		textBox.PlaceholderColor3 = Color3.fromRGB(0, 0, 0)
		textBox.PlaceholderText = "String"
		textBox.Text = value
		textBox.TextColor3 = Color3.fromRGB(0, 0, 0)
		textBox.TextSize = 16
		textBox.Parent = frame

		UICorner.CornerRadius = UDim.new(0.2, 0)
		UICorner.Parent = textBox
		
		--\
		textBox:GetPropertyChangedSignal("Text"):Connect(function()
			textBox.Text = value
		end)
		--/
		
		return label
	end,
	["Button"] = function(key, value) -- signal
		local button = Instance.new("Frame")
		local UIPadding = Instance.new("UIPadding")
		local textLabel = Instance.new("TextLabel")
		local frame = Instance.new("Frame")
		local textButton = Instance.new("TextButton")
		local UICorner = Instance.new("UICorner")

		button.AutomaticSize = Enum.AutomaticSize.Y
		button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		button.BackgroundTransparency = 0.9
		button.BorderColor3 = Color3.fromRGB(0, 0, 0)
		button.BorderSizePixel = 0
		button.Name = "Button"
		button.Size = UDim2.new(1, 0, 0, 20)

		UIPadding.PaddingBottom = UDim.new(0, 5)
		UIPadding.PaddingTop = UDim.new(0, 5)
		UIPadding.Parent = button

		textLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		textLabel.BackgroundTransparency = 1
		textLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		textLabel.BorderSizePixel = 0
		textLabel.Position = UDim2.fromOffset(5, 0)
		textLabel.Size = UDim2.new(0.5, -5, 1, 0)
		textLabel.FontFace = fontFaces["Comic Neue Angular Bold"]
		textLabel.Text = key or "Button"
		textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		textLabel.TextSize = 16
		textLabel.TextXAlignment = Enum.TextXAlignment.Left
		textLabel.Parent = button

		frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		frame.BackgroundTransparency = 1
		frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		frame.BorderSizePixel = 0
		frame.Position = UDim2.fromScale(0.5, 0)
		frame.Size = UDim2.new(0.5, -5, 0, 25)
		frame.Parent = button

		textButton.AutoButtonColor = false
		textButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		textButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
		textButton.BorderSizePixel = 0
		textButton.Position = UDim2.fromScale(0.5, 0)
		textButton.Size = UDim2.new(0.5, 0, 0, 25)
		textButton.FontFace = fontFaces["Comic Neue Angular Bold"]
		textButton.Text = value or ""
		textButton.TextColor3 = Color3.fromRGB(0, 0, 0)
		textButton.TextSize = 16
		textButton.Parent = frame

		UICorner.CornerRadius = UDim.new(0.2, 0)
		UICorner.Parent = textButton

		return button
	end,
	["Switch"] = function(key, value, default) -- boolean
		local switch = Instance.new("Frame")
		local UIPadding = Instance.new("UIPadding")
		local textLabel = Instance.new("TextLabel")
		local frame = Instance.new("Frame")
		local frame_2 = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local textButton = Instance.new("TextButton")
		local UICorner_2 = Instance.new("UICorner")

		switch.AutomaticSize = Enum.AutomaticSize.Y
		switch.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		switch.BackgroundTransparency = 0.9
		switch.BorderColor3 = Color3.fromRGB(0, 0, 0)
		switch.BorderSizePixel = 0
		switch.Name = "Switch"
		switch.Size = UDim2.new(1, 0, 0, 20)

		UIPadding.PaddingBottom = UDim.new(0, 5)
		UIPadding.PaddingTop = UDim.new(0, 5)
		UIPadding.Parent = switch

		textLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		textLabel.BackgroundTransparency = 1
		textLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		textLabel.BorderSizePixel = 0
		textLabel.Position = UDim2.fromOffset(5, 0)
		textLabel.Size = UDim2.new(0.5, -5, 1, 0)
		textLabel.FontFace = fontFaces["Comic Neue Angular Bold"]
		textLabel.Text = key or "Switch"
		textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		textLabel.TextSize = 16
		textLabel.TextXAlignment = Enum.TextXAlignment.Left
		textLabel.Parent = switch

		frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		frame.BackgroundTransparency = 1
		frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		frame.BorderSizePixel = 0
		frame.Position = UDim2.fromScale(0.5, 0)
		frame.Size = UDim2.new(0.5, -5, 0, 25)
		frame.Parent = switch

		frame_2.BackgroundColor3 = Color3.fromRGB(140, 140, 140)
		frame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
		frame_2.BorderSizePixel = 0
		frame_2.Position = UDim2.new(1, -25, 0, 0)
		frame_2.Size = UDim2.fromOffset(25, 25)
		frame_2.Parent = frame

		UICorner.CornerRadius = UDim.new(0.2, 0)
		UICorner.Parent = frame_2

		UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		UIStroke.BorderStrokePosition = Enum.BorderStrokePosition.Inner
		UIStroke.Color = Color3.fromRGB(255, 255, 255)
		UIStroke.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
		UIStroke.Thickness = 0.1
		UIStroke.Parent = frame_2

		textButton.AutoButtonColor = false
		textButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		textButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
		textButton.BorderSizePixel = 0
		textButton.Position = UDim2.new(0.6, -30, 0, 0)
		textButton.Size = UDim2.new(0.4, 0, 0, 25)
		textButton.FontFace = fontFaces["Comic Neue Angular Bold"]
		textButton.Text = value or ""
		textButton.TextColor3 = Color3.fromRGB(0, 0, 0)
		textButton.TextSize = 16
		textButton.Parent = frame

		UICorner_2.CornerRadius = UDim.new(0.2, 0)
		UICorner_2.Parent = textButton

		--\
		local boolVI = Instance.new("BoolValue", switch)
		boolVI.Value = default or boolVI.Value

		local function update()
			if boolVI.Value then
				frame_2.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
			else
				frame_2.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
			end
		end

		textButton.MouseButton1Down:Connect(function()
			boolVI.Value = not boolVI.Value
			update()
		end)

		update()
		--/

		return switch, boolVI, 4
	end,
	["Slider"] = function(key, steps, default, offset) -- float
		local frame = Instance.new("Frame")
		local UIPadding = Instance.new("UIPadding")
		local textLabel = Instance.new("TextLabel")
		local frame_2 = Instance.new("Frame")
		local frame_3 = Instance.new("Frame")
		local frame_4 = Instance.new("Frame")
		local textButton = Instance.new("TextButton")
		local UICorner = Instance.new("UICorner")

		frame.AutomaticSize = Enum.AutomaticSize.Y
		frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		frame.BackgroundTransparency = 0.9
		frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		frame.BorderSizePixel = 0
		frame.Name = "Slider"
		frame.Size = UDim2.new(1, 0, 0, 20)

		UIPadding.PaddingBottom = UDim.new(0, 5)
		UIPadding.PaddingTop = UDim.new(0, 5)
		UIPadding.Parent = frame

		textLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		textLabel.BackgroundTransparency = 1
		textLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		textLabel.BorderSizePixel = 0
		textLabel.Position = UDim2.fromOffset(5, 0)
		textLabel.Size = UDim2.new(0.5, -5, 1, 0)
		textLabel.FontFace = fontFaces["Comic Neue Angular Bold"]
		textLabel.Text = key or "Slider"
		textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		textLabel.TextSize = 16
		textLabel.TextXAlignment = Enum.TextXAlignment.Left
		textLabel.Parent = frame

		frame_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		frame_2.BackgroundTransparency = 1
		frame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
		frame_2.BorderSizePixel = 0
		frame_2.Position = UDim2.fromScale(0.5, 0)
		frame_2.Size = UDim2.new(0.5, -5, 0, 25)
		frame_2.Parent = frame

		frame_3.AnchorPoint = Vector2.new(0, 0.5)
		frame_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		frame_3.BackgroundTransparency = 0.5
		frame_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
		frame_3.BorderSizePixel = 0
		frame_3.Position = UDim2.fromScale(0, 0.5)
		frame_3.Size = UDim2.fromScale(1, 0.2)
		frame_3.Parent = frame_2

		frame_4.AnchorPoint = Vector2.new(0.5, 0.5)
		frame_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		frame_4.BackgroundTransparency = 1
		frame_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
		frame_4.BorderSizePixel = 0
		frame_4.Position = UDim2.fromScale(0.5, 0.5)
		frame_4.Name = "Scale"
		frame_4.Size = UDim2.new(1, -25, 0.2, 0)
		frame_4.ZIndex = 2
		frame_4.Parent = frame_2

		textButton.AnchorPoint = Vector2.new(0.5, 0.5)
		textButton.AutoButtonColor = false
		textButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		textButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
		textButton.BorderSizePixel = 0
		textButton.Position = UDim2.fromScale(0, 0.5)
		textButton.Size = UDim2.fromOffset(25, 25)
		textButton.FontFace = fontFaces["Comic Neue Angular Bold"]
		textButton.Text = "n/a."
		textButton.TextColor3 = Color3.fromRGB(0, 0, 0)
		textButton.TextSize = 16
		textButton.Parent = frame_4

		UICorner.CornerRadius = UDim.new(0.2, 0)
		UICorner.Parent = textButton

		--\
		offset = offset or 0

		local numberVI = Instance.new("NumberValue", frame)
		numberVI.Value = default or numberVI.Value

		slider(textButton, function(X, Y)
			local newValue = steps == nil and roundDown(X, 3) or steps * X + offset
			textButton.Text = string.format("%s/%s.", newValue, (steps or 1) + offset)
			numberVI.Value = newValue
		end, true, false, {
			steps = steps,
			defaultX = steps == nil and numberVI.Value or (numberVI.Value - offset)/steps
		})
		--/

		return frame, numberVI, 4
	end,
	["Counter"] = function(key, default, offset) -- integer
		local counter = Instance.new("Frame")
		local UIPadding = Instance.new("UIPadding")
		local textLabel = Instance.new("TextLabel")
		local frame = Instance.new("Frame")
		local textButton = Instance.new("TextButton")
		local UICorner = Instance.new("UICorner")
		local UIListLayout = Instance.new("UIListLayout")
		local textButton_2 = Instance.new("TextButton")
		local UICorner_2 = Instance.new("UICorner")
		local textBox = Instance.new("TextBox")
		local UICorner_3 = Instance.new("UICorner")

		counter.AutomaticSize = Enum.AutomaticSize.Y
		counter.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		counter.BackgroundTransparency = 0.9
		counter.BorderColor3 = Color3.fromRGB(0, 0, 0)
		counter.BorderSizePixel = 0
		counter.Name = "Counter"
		counter.Size = UDim2.new(1, 0, 0, 20)

		UIPadding.PaddingBottom = UDim.new(0, 5)
		UIPadding.PaddingTop = UDim.new(0, 5)
		UIPadding.Parent = counter

		textLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		textLabel.BackgroundTransparency = 1
		textLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		textLabel.BorderSizePixel = 0
		textLabel.Position = UDim2.fromOffset(5, 0)
		textLabel.Size = UDim2.new(0.5, -5, 1, 0)
		textLabel.FontFace = fontFaces["Comic Neue Angular Bold"]
		textLabel.Text = key or "Counter"
		textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		textLabel.TextSize = 16
		textLabel.TextXAlignment = Enum.TextXAlignment.Left
		textLabel.Parent = counter

		frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		frame.BackgroundTransparency = 1
		frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		frame.BorderSizePixel = 0
		frame.Position = UDim2.fromScale(0.5, 0)
		frame.Size = UDim2.new(0.5, -5, 0, 25)
		frame.Parent = counter

		textButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		textButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
		textButton.BorderSizePixel = 0
		textButton.LayoutOrder = 2
		textButton.Position = UDim2.new(0.6, -30, 0, 0)
		textButton.Size = UDim2.fromOffset(25, 25)
		textButton.Font = 2
		textButton.Text = "ʌ"
		textButton.TextColor3 = Color3.fromRGB(0, 0, 0)
		textButton.TextSize = 16
		textButton.Parent = frame

		UICorner.CornerRadius = UDim.new(0.2, 0)
		UICorner.Parent = textButton

		UIListLayout.Padding = UDim.new(0, 5)
		UIListLayout.FillDirection = Enum.FillDirection.Horizontal
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
		UIListLayout.Parent = frame

		textButton_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		textButton_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
		textButton_2.BorderSizePixel = 0
		textButton_2.Position = UDim2.new(0.6, -30, 0, 0)
		textButton_2.Size = UDim2.fromOffset(25, 25)
		textButton_2.Font = 2
		textButton_2.Text = "v"
		textButton_2.TextColor3 = Color3.fromRGB(0, 0, 0)
		textButton_2.TextSize = 16
		textButton_2.Parent = frame

		UICorner_2.CornerRadius = UDim.new(0.2, 0)
		UICorner_2.Parent = textButton_2

		textBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		textBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
		textBox.BorderSizePixel = 0
		textBox.ClearTextOnFocus = false
		textBox.LayoutOrder = 1
		textBox.Size = UDim2.fromScale(0.6, 1)
		textBox.FontFace = fontFaces["Comic Neue Angular Bold"]
		textBox.PlaceholderColor3 = Color3.fromRGB(128, 128, 128)
		textBox.PlaceholderText = "Number"
		textBox.Text = ""
		textBox.TextColor3 = Color3.fromRGB(0, 0, 0)
		textBox.TextSize = 16
		textBox.Parent = frame

		UICorner_3.CornerRadius = UDim.new(0.2, 0)
		UICorner_3.Parent = textBox

		--\
		offset = offset or 1

		local intVI = Instance.new("IntValue", counter)
		intVI.Value = default or intVI.Value

		local function update()
			textBox.Text = tostring(intVI.Value)
		end

		textBox.FocusLost:Connect(function(enterPressed)
			local newValue = tonumber(textBox.Text)
			if newValue ~= nil then
				intVI.Value = newValue
			end
			update()
		end)

		textButton.MouseButton1Down:Connect(function()
			intVI.Value += offset
			update()
		end)

		textButton_2.MouseButton1Down:Connect(function()
			intVI.Value -= offset
			update()
		end)

		update()
		--/

		return counter, intVI, 3
	end,
	--	["ColorPicker"] = function() -- color3

	--	end,

	["ColorSwatch"] = function(key, colors, default) -- color3
		local colorSwatch = Instance.new("Frame")
		local UIPadding = Instance.new("UIPadding")
		local textLabel = Instance.new("TextLabel")
		local frame = Instance.new("Frame")
		local UIListLayout = Instance.new("UIListLayout")

		colorSwatch.AutomaticSize = Enum.AutomaticSize.Y
		colorSwatch.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		colorSwatch.BackgroundTransparency = 0.9
		colorSwatch.BorderColor3 = Color3.fromRGB(0, 0, 0)
		colorSwatch.BorderSizePixel = 0
		colorSwatch.Name = "ColorSwatch"
		colorSwatch.Size = UDim2.new(1, 0, 0, 20)

		UIPadding.PaddingBottom = UDim.new(0, 5)
		UIPadding.PaddingTop = UDim.new(0, 5)
		UIPadding.Parent = colorSwatch

		textLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		textLabel.BackgroundTransparency = 1
		textLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		textLabel.BorderSizePixel = 0
		textLabel.Position = UDim2.fromOffset(5, 0)
		textLabel.Size = UDim2.new(0.5, -5, 1, 0)
		textLabel.FontFace = fontFaces["Comic Neue Angular Bold"]
		textLabel.Text = key or "ColorSwatch"
		textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		textLabel.TextSize = 16
		textLabel.TextXAlignment = Enum.TextXAlignment.Left
		textLabel.Parent = colorSwatch

		frame.AutomaticSize = Enum.AutomaticSize.Y
		frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		frame.BackgroundTransparency = 1
		frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		frame.BorderSizePixel = 0
		frame.Position = UDim2.fromScale(0.5, 0)
		frame.Size = UDim2.new(0.5, -5, 0, 25)
		frame.Parent = colorSwatch

		UIListLayout.Padding = UDim.new(0, 5)
		UIListLayout.FillDirection = Enum.FillDirection.Horizontal
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.Wraps = true
		UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
		UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
		UIListLayout.Parent = frame

		local function createButton()
			local textButton = Instance.new("TextButton")
			local UICorner = Instance.new("UICorner")
			local UIStroke = Instance.new("UIStroke")

			textButton.AutoButtonColor = false
			textButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
			textButton.BorderSizePixel = 0
			textButton.Size = UDim2.fromOffset(20, 20)
			textButton.Text = ""
			textButton.TextColor3 = Color3.fromRGB(0, 0, 0)
			textButton.TextSize = 14

			UICorner.CornerRadius = UDim.new(0.5, 0)
			UICorner.Parent = textButton

			UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			UIStroke.Color = Color3.fromRGB(255, 255, 255)
			UIStroke.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
			UIStroke.Thickness = 0.1
			UIStroke.Parent = textButton

			return textButton
		end

		--\
		local color3VI = Instance.new("Color3Value", colorSwatch)
		color3VI.Value = default or color3VI.Value

		for _, color3 in colors or {color3VI.Value} do
			local textButton = createButton()
			textButton.BackgroundColor3 = color3
			textButton.MouseButton1Down:Connect(function()
				color3VI.Value = color3
			end)
			textButton.Parent = frame
		end
		--/

		return colorSwatch, color3VI, 4
	end,
	--	["Choice"] = function() -- string r
	-- пример: Players | (<) ovtsehsus (>)
	--	end
}

local function createOpenGUIButton()
	local textButton = Instance.new("TextButton")
	local textButton_2 = Instance.new("TextButton")

	textButton.AutoButtonColor = false
	textButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	textButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	textButton.BorderSizePixel = 0
	textButton.Size = UDim2.fromOffset(80, 20)
	textButton.FontFace = fontFaces["Comic Neue Angular Regular"]
	textButton.Text = "Open GUI"
	textButton.TextColor3 = Color3.fromRGB(0, 0, 0)
	textButton.TextSize = 20
	textButton.Visible = false
	
	textButton_2.AutoButtonColor = false
	textButton_2.AnchorPoint = Vector2.new(0, 0.5)
	textButton_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	textButton_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	textButton_2.BorderSizePixel = 0
	textButton_2.Position = UDim2.new(1, 20, 0.5, 0)
	textButton_2.Size = UDim2.fromOffset(20, 20)
	textButton_2.Text = ""
	textButton_2.Parent = textButton

	return textButton
end
--/ TODO: UI 1/1

local GUI = {
	instance = nil,
	V = V,
}

local Window = {
	instance = nil,
	tabs = {},
	_currentTab = nil,
	_sections = { 
		--	[tabOrder] = {
		--		[I] = Section
		--	}
	}
}

local Section = {
	instance = nil,
	_elements = {
		--	[element_i] = {elementType, ...:args}
	},
	_groups = {
		--	[iR_k] = NumberRange
	}
}
-- iR_k: index range key

local function deepClone(arg1t)
	local i1t1 = {}
	for k, v in pairs(arg1t) do
		if type(v) == "table" then
			i1t1[k] = deepClone(v)
		else
			i1t1[k] = v
		end
	end
	return i1t1
end -- DeepSeek

--\ Перетаскивание & Масштабирование
local function makeDraggable(
	object: GuiObject,
	dragger: GuiObject,
	TI: TweenInfo,
	useGrid: boolean, gridCellSize: number,
	UICorner: UICorner, offsetForUICorner: number
)
	TI = TI or TweenInfo.new(0)
	useGrid = useGrid or false
	gridCellSize = gridCellSize or 20

	local useTweens = TI.Time ~= 0
	offsetForUICorner = offsetForUICorner or (if useGrid or (not useTweens) then 0 else 2)

	local drag = false

	local dragStartPosition
	local objectStartPosition

	local defaultCornerRadius = if UICorner == nil then nil else UICorner.CornerRadius

	local function update(inputObject)
		local delta = inputObject.Position - dragStartPosition

		local XPosition = objectStartPosition.X.Offset + delta.X
		local YPosition = objectStartPosition.Y.Offset + delta.Y

		if useGrid then
			XPosition = floor(XPosition/gridCellSize) * gridCellSize
			YPosition = floor(YPosition/gridCellSize) * gridCellSize
		end

		local endObjectXPosition = viewportSize.X - object.AbsoluteSize.X
		local endObjectYPosition = viewportSize.Y - object.AbsoluteSize.Y

		local newObjectPosition = UDim2.new(
			0, clamp(XPosition, 0, endObjectXPosition),
			0, clamp(YPosition, 0, endObjectYPosition)
		)

		local function updateUICorner()
			if UICorner ~= nil then
				local objectPosition = object.Position

				local startObjectXPosition = objectPosition.X.Offset
				local startObjectYPosition = objectPosition.Y.Offset

				if (startObjectXPosition <= 0 + offsetForUICorner or startObjectYPosition <= 0 + offsetForUICorner or
					startObjectXPosition >= endObjectXPosition - offsetForUICorner or startObjectYPosition >= endObjectYPosition - offsetForUICorner)
				then
					if useTweens then
						TweenService:Create(UICorner, TI, {CornerRadius = UDim.new(0, 0)}):Play()
					else
						UICorner.CornerRadius = UDim.new(0, 0)
					end
				else
					if useTweens then
						TweenService:Create(UICorner, TI, {CornerRadius = defaultCornerRadius}):Play()
					else
						UICorner.CornerRadius = defaultCornerRadius
					end
				end
			end
		end

		if useTweens then
			TweenService:Create(object, TI, {Position = newObjectPosition}):Play()

			coroutine.wrap(function()
				wait(TI.Time)

				updateUICorner()
			end)()
		else
			object.Position = newObjectPosition

			updateUICorner()
		end
	end

	dragger.MouseButton1Down:Connect(function()
		dragStartPosition = Vector3.new(mouse.X, mouse.Y, 0)
		objectStartPosition = object.Position

		local connection
		connection = UserInputService.InputEnded:Connect(function(inputObject)
			if inputObject.UserInputState == Enum.UserInputState.End then
				connection:Disconnect()

				update(inputObject)

				drag = false
			end
		end)

		drag = true
	end)

	UserInputService.InputChanged:Connect(function(inputObject)
		if drag and (inputObject.UserInputType == Enum.UserInputType.MouseMovement
			or inputObject.UserInputType == Enum.UserInputType.Touch)
		then
			update(inputObject)
		end
	end)
end

local function makeResizable(scrollingFrame, -- nested args
	object: GuiObject,
	resizer: GuiObject,
	minXSize: number, minYSize: number,
	maxXSize: number, maxYSize: number,
	TI: TweenInfo,
	useGrid: boolean, gridCellSize: number
)
	TI = TI or TweenInfo.new(0)
	useGrid = useGrid or false
	gridCellSize = gridCellSize or 20

	local useTweens = TI.Time ~= 0

	local drag = false

	local dragStartPosition
	local objectStartSize

	local shift = false

	local function update(inputObject)
		local delta = inputObject.Position - dragStartPosition

		local XSize = objectStartSize.X.Offset + delta.X
		local YSize = objectStartSize.Y.Offset + delta.Y

		if useGrid then
			XSize = floor(XSize/gridCellSize) * gridCellSize
			YSize = floor(YSize/gridCellSize) * gridCellSize
		end

		local newObjectSize = UDim2.new(
			0, clamp(XSize, minXSize, maxXSize),
			0, clamp(YSize, minYSize, maxYSize)
		)

		local objectPosition = object.Position
		local objectSize = object.Size

		local newObjectPosition = objectPosition - UDim2.fromOffset(
			max(objectPosition.X.Offset + objectSize.X.Offset - viewportSize.X, 0),
			max(objectPosition.Y.Offset + objectSize.Y.Offset - viewportSize.Y, 0)
		)

		if useTweens then
			TweenService:Create(object, TI, {Size = newObjectSize, Position = newObjectPosition}):Play()
		else
			object.Size = newObjectSize
			object.Position = newObjectPosition
		end

		--\ moving scrollingFrame (nested)
		if not shift and newObjectSize.X.Offset > 601 then
			shift = true
			scrollingFrame.Position = UDim2.fromOffset(5, 55)
		elseif shift and newObjectSize.X.Offset < 602 then
			shift = false
			scrollingFrame.Position = UDim2.fromOffset(5, 80)
		end
		--/
	end

	resizer.MouseButton1Down:Connect(function()
		dragStartPosition = Vector3.new(mouse.X, mouse.Y, 0)
		objectStartSize = object.Size

		local connection
		connection = UserInputService.InputEnded:Connect(function(inputObject)
			if inputObject.UserInputState == Enum.UserInputState.End then
				connection:Disconnect()
				drag = false
			end
		end)

		drag = true
	end)

	UserInputService.InputChanged:Connect(function(inputObject)
		if drag and (inputObject.UserInputType == Enum.UserInputType.MouseMovement
			or inputObject.UserInputType == Enum.UserInputType.Touch)
		then
			update(inputObject)
		end
	end)
end
--/

local function swapFGToBGColor3(instance)
	local v3 = instance.BackgroundColor3
	instance.BackgroundColor3 = instance.TextColor3
	instance.TextColor3 = v3
end

function GUI:Window(title) -- TODO: Window
	local new = deepClone(Window)
	local window = createWindow(title or self.windowTitle or "Window V:" .. V, minWindowSize)
	new.instance = window

	makeDraggable(window, window.Top)
	makeResizable(window.Frame.ScrollingFrame, window, window.Bottom.Resizer, 450, 575, maxWindowSizeX, maxWindowSizeY)
	
	local textButton = createOpenGUIButton()
	textButton.MouseButton1Down:Connect(function()
		textButton.Visible = false
		ContextActionService:UnbindAction(self.instance.Name)
		window.Visible = true
	end)
	textButton.Position = UDim2.fromOffset(maxWindowSizeX * math.random(2, 8)/10, maxWindowSizeY * math.random(2, 8)/10)
	makeDraggable(textButton, textButton.TextButton)
	textButton.Parent = self.instance -- .Ignore

	window.Top.Frame.Hide.MouseButton1Down:Connect(function()
		window.Visible = false
		textButton.Visible = true
		ContextActionService:BindAction(self.instance.Name, function(actionName, inputState)
			if inputState == Enum.UserInputState.Begin then
				ContextActionService:UnbindAction(actionName)
				textButton.Visible = false
				window.Visible = true
			end
		end, true)
		ContextActionService:SetTitle(self.instance.Name, "Open GUI")
	end)

	window.Top.Frame.Close.MouseButton1Down:Connect(function()
		self:Destroy()
	end)

	for _, tab in window.Frame.Tabs:GetChildren() do
		if tab.ClassName == "TextButton" then
			new.tabs[tab.LayoutOrder] = tab
			new._sections[tab.LayoutOrder] = {}
			tab.MouseButton1Down:Connect(function()
				if tab.LayoutOrder == new._currentTab then return end
				new:loadTab(tab.LayoutOrder)
			end)
		end
	end

	local bindableEvent = Instance.new("BindableEvent", new.instance)
	bindableEvent.Name = "TabChanged"

	new.event_TabChanged = bindableEvent.Event

	--\ TODO: Settings
	local Settings = new:Section(10)
	--code

	new.event_TabChanged:Connect(function(tabOrder)
		if tabOrder == 10 then
			--code
		end
	end)
	--/

	window.Parent = self.instance
	return new
end

function Window:tabNameToOrder(tabName)
	for _, tab in self.tabs do
		if tab.Text == tabName then
			return tab.LayoutOrder
		end
	end
end

local function getChildrenNotIsA(parent, isA)
	local i1t1 = {}
	local i1n1 = 0
	for _, child in parent:GetChildren() do
		if not child:IsA(isA) then
			i1n1 = i1n1 + 1
			i1t1[i1n1] = child
		end
	end
	return i1t1, i1n1
end

function Window:loadTab(tabOrder)
	tabOrder = tabOrder or self._currentTab
	if self._currentTab == nil then
		tabOrder = tabOrder or 0
	else
		swapFGToBGColor3(self.tabs[self._currentTab])
		--\ cleanup
		for _, child in self.instance.Frame.ScrollingFrame:GetChildren() do
			if child.ClassName == "Frame" then
				child:Destroy()
			end
		end
		--/
	end
	if tabOrder == self._currentTab then return end
	self._currentTab = tabOrder
	self.instance["TabChanged"]:Fire(tabOrder)
	swapFGToBGColor3(self.tabs[tabOrder])
	if self._sections[tabOrder][1] == nil then return end
	for _, v in self._sections[tabOrder] do
		local section = createSection()
		for i, element in v._elements do
			local createFunction = elementTypes[element[1]]
			if createFunction == nil then continue end
			local instance, valueInstance, value_i = createFunction(table.unpack(element, 2))
			if valueInstance ~= nil then
				valueInstance.Changed:Connect(function(newValue)
					element[value_i] = newValue
				end)
				element[value_i] = valueInstance.Value
			end
			instance.Name = tostring(i)
			instance.Parent = section
		end
		for k, iR in v._groups do
			local iR_k, name = k:match("([^,]+),(.*)")
			local group = createGroup(name)
			group.Name = iR_k
			for i = iR.Min, iR.Max do
				local element = section[i]
				local childOrChildren, numberOf = getChildrenNotIsA(element.Frame, "UILayout")
				if numberOf > 1 then
					local frame = Instance.new("Frame")
					frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					frame.BackgroundTransparency = 1
					frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
					frame.BorderSizePixel = 0
					frame.Size = UDim2.new(1, 0, 0, 25)
					for _, child in childOrChildren do
						local objectVI = Instance.new("ObjectValue", child.Parent)
						objectVI.Name = child.Name
						objectVI.Value = child
						child.Parent = frame
					end
					frame.Parent = group.Frame
				else
					local objectVI = Instance.new("ObjectValue", childOrChildren[1].Parent)
					objectVI.Name = childOrChildren[1].Name
					objectVI.Value = childOrChildren[1]
					childOrChildren[1].Parent = group.Frame
				end
				element.Visible = false
				--element:Destroy()
			end
			group.Parent = section
		end
		section.Parent = self.instance.Frame.ScrollingFrame
		v.instance = section
	end
end

function Window:Section(tabOrder, text)
	--if tabOrder == 10 or tabOrder == 8 then return end
	local new = deepClone(Section)
	if text ~= nil then
		new:AddElement("Text", text)
	end
	table.insert(self._sections[tabOrder], new)
	return new
end

function Section:AddElement(elementType, ...)
	local i1n1 = #self._elements
	self._elements[i1n1 + 1] = {elementType, ...}
	return i1n1 + 1
end

function Section:Element_isInGroup(element_i)
	for k, iR in self._groups do
		if element_i >= iR.Min and element_i <= iR.Max then
			return k
		end
	end
end

function Section:GetElement(element_i)
	local iR_k = self:Element_isInGroup(element_i)
	local children = getChildrenNotIsA(self.instance[element_i].Frame, "UILayout")
	if iR_k ~= nil then
		local i2t1 = {}
		for i, objectVI in children do
			i2t1[i] = objectVI.Value
		end
		children = i2t1
	end
	return table.unpack(children)
end

function Section:AddGroup(name, iR: NumberRange)
	if iR.Max < 2 then return end
	local iR_k = string.format("%s-%s,%s", iR.Min, iR.Max, name)
	if self._groups[iR_k] ~= nil then return end
	self._groups[iR_k] = iR
	return iR_k
end


function GUI:Destroy()
	self.instance:Destroy()
	_G.hacked = nil
end

function Window:Destroy()
	self.instance:Destroy()
end

return function(name, instance: ScreenGui, parent) -- init
	GUI.instance = instance or createRoot(name)
	GUI.windowTitle = name
	GUI.instance.Parent = parent or player:WaitForChild("PlayerGui")
	return GUI
end

-- by ovtsehsus / Sushestvo
