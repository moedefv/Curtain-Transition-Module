local DefaultProperties = {
	Name = "IrisFrame",
	Size = UDim2.fromScale(0.078, 0.178),
	AnchorPoint = Vector2.new(0.5, 0.5),
	Position = UDim2.fromScale(0.5, 0.5),
	Visible = false,
}

local Children = {
	UIScale = {
		Scale = 0
	},
	UICorner = {
		CornerRadius = UDim.new(1, 0)
	},
	UIAspectRatioConstraint = {}
}

return function()
	local frame = Instance.new("Frame")
	
	for property, value in DefaultProperties do
		frame[property] = value
	end
	
	for child, childProperties in Children do
		local element = Instance.new(child)
		
		for property, value in childProperties do
			element[property] = value
		end
		
		element.Parent = frame
	end
	
	return {Frame = frame}
end