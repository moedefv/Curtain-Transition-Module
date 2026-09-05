local DefaultProperties = {
	Size = UDim2.fromScale(1, 1),
	BackgroundTransparency = 1,
	Name = "SwipeFrame",
}

local columns = 40
local heightScale = 0.05

return function()
	local parent = Instance.new("Frame")
	
	for property, value in DefaultProperties do
		parent[property] = value
	end
	
	local screenSize = workspace.CurrentCamera.ViewportSize
	local cellWidth = math.floor(screenSize.X / columns)
	local cellHeight = math.floor(screenSize.Y)
	
	local columnCount = 0
	
	for column = 1, columns do
		columnCount += 1
		local cellW = column == columns and screenSize.X - cellWidth * (columns - 1) or cellWidth

		local centerX = cellWidth * (column - 1) + cellW / 2
		local centerY = cellHeight / 2

		local columnFrame = Instance.new("Frame")
		columnFrame.AnchorPoint = Vector2.new(0.5, 0.5)
		columnFrame.BackgroundTransparency = 1
		columnFrame.BorderSizePixel = 0
		columnFrame.Size = UDim2.new(0, cellW, heightScale, 0)
		columnFrame.Position = UDim2.new(0, centerX, 0, centerY)
		columnFrame.Name = columnCount
		columnFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		columnFrame.Visible = false

		columnFrame.Parent = parent
	end
	
	local connection
	connection = workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
		local newScreenSize = workspace.CurrentCamera.ViewportSize
		local newCellWidth = math.floor(newScreenSize.X / columns)

		for _, columnFrame in parent:GetChildren() do
			if not columnFrame:IsA("Frame") then continue end

			local index = tonumber(columnFrame.Name)
			local cellW = index == columns and newScreenSize.X - newCellWidth * (columns - 1) or newCellWidth
			local centerX = newCellWidth * (index - 1) + cellW / 2
			local centerY = newScreenSize.Y / 2

			columnFrame.Size = UDim2.new(0, cellW, heightScale, 0)
			columnFrame.Position = UDim2.new(0, centerX, 0, centerY)
		end
	end)

	return {Frame = parent, Connection = connection}
end