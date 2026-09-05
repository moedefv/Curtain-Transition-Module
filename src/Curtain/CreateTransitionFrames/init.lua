return function(transitionGUI)
	local allFrames = {}

	for _, module in script:GetChildren() do
		local handler = require(module)
		table.insert(allFrames, handler())
	end

	for _, frameInfo in allFrames do
		local frame = frameInfo.Frame
		frame.Parent = transitionGUI
	end

	return allFrames
end