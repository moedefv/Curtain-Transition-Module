local DefaultProperties = {
	Size = UDim2.fromScale(1, 1),
	BackgroundTransparency = 1,
	Name = "GridFrame",
}

local columns = 10
local rows = 4

return function()
	local parent = Instance.new("Frame")
	
	for property, value in DefaultProperties do
		parent[property] = value
	end
	
	local screenSize = workspace.CurrentCamera.ViewportSize
	local cellWidth = math.floor(screenSize.X / columns)
	local cellHeight = math.floor(screenSize.Y / rows)
	
	local squareCount = 0
	
	for row = 1, rows do
		for column = 1, columns do
			squareCount += 1
			local cellW = column == columns and screenSize.X - cellWidth * (columns - 1) or cellWidth
			local cellH = row == rows and screenSize.Y - cellHeight * (rows - 1) or cellHeight

			local centerX = cellWidth * (column - 1) + cellW / 2
			local centerY = cellHeight * (row - 1) + cellH / 2

			local square = Instance.new("Frame")
			square.AnchorPoint = Vector2.new(0.5, 0.5)
			square.BackgroundTransparency = 1
			square.BorderSizePixel = 0
			square.Size = UDim2.new(0, cellW, 0, cellH)
			square.Position = UDim2.new(0, centerX, 0, centerY)
			square.Name = squareCount
			square.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			square.Visible = false

			local uiScale = Instance.new("UIScale")
			uiScale.Scale = 0
			uiScale.Name = "UIScale"
			uiScale.Parent = square
			
			square.Parent = parent
		end
	end
	
	--// if screen size changes
	local connection
	connection = workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
		local screenSize = workspace.CurrentCamera.ViewportSize
		local cellWidth = math.floor(screenSize.X / columns)
		local cellHeight = math.floor(screenSize.Y / rows)

		for _, square in parent:GetChildren() do
			if not square:IsA("Frame") then continue end

			local index = tonumber(square.Name)
			local column = ((index - 1) % columns) + 1
			local row = math.floor((index - 1) / columns) + 1

			local cellW = column == columns and screenSize.X - cellWidth * (columns - 1) or cellWidth
			local cellH = row == rows and screenSize.Y - cellHeight * (rows - 1) or cellHeight

			local centerX = cellWidth * (column - 1) + cellW / 2
			local centerY = cellHeight * (row - 1) + cellH / 2

			square.Size = UDim2.new(0, cellW, 0, cellH)
			square.Position = UDim2.new(0, centerX, 0, centerY)
		end
	end)
	
	return {Frame = parent, Connection = connection}
end