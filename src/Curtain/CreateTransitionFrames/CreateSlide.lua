local DefaultProperties = {
	Size = UDim2.fromScale(1, 1),
	Position = UDim2.fromScale(1, 0),
	Name = "SlideFrame",
	Visible = false,
}

return function()
	local frame = Instance.new("Frame")
	
	for property, value in DefaultProperties do
		frame[property] = value
	end
	
	return {Frame = frame}
end