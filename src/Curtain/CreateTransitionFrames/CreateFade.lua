local DefaultProperties = {
	Size = UDim2.fromScale(1, 1),
	BackgroundTransparency = 1,
	Name = "FadeFrame",
	Visible = false,
}

return function()
	local frame = Instance.new("Frame")

	for property, value in DefaultProperties do
		frame[property] = value
	end

	return {Frame = frame}
end