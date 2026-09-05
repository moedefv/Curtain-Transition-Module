local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Player = Players.LocalPlayer
local PlayerGUI = Player.PlayerGui
local TransitionGUI = PlayerGUI:WaitForChild("TransitionGUI")
local SwipeFrame = TransitionGUI:WaitForChild("SwipeFrame")

local function SwipeIn(info, Color)
	local inTween

	for i = 1, 40 do
		local column = SwipeFrame[i]
		
		local expandTween = TweenService:Create(column, info, {Size = UDim2.new(column.Size.X.Scale, column.Size.X.Offset, 1, 0)})
		inTween = TweenService:Create(column, info, {BackgroundTransparency = 0})
		
		column.BackgroundColor3 = Color or Color3.fromRGB(0, 0, 0)
		column.Visible = true
		
		inTween:Play()
		expandTween:Play()
		
		task.wait(0.02)
	end

	inTween.Completed:Wait()
end

local function SwipeOut(info, Color)
	local outTween

	for i = 1, 40 do
		local column = SwipeFrame[i]
		
		local compressTween = TweenService:Create(column, info, {Size = UDim2.new(column.Size.X.Scale, column.Size.X.Offset, 0, 0)})
		outTween = TweenService:Create(column, info, {BackgroundTransparency = 1})
		
		column.BackgroundColor3 = Color or Color3.fromRGB(0, 0, 0)

		outTween:Play()
		compressTween:Play()
		
		task.wait(0.02)
	end

	outTween.Completed:Wait()
	
	for _, column in SwipeFrame:GetChildren() do
		if not column:IsA("Frame") then continue end
		
		column.Visible = false
	end
end

return function(frame1, frame2, isScreenGuiFrame1, isScreenGuiFrame2, transitionConfig, customCallback)
	local info
	local Color
	
	if not transitionConfig then
		info = TweenInfo.new(0.5, Enum.EasingStyle.Linear)
	else
		local Duration = transitionConfig["Duration"]
		local EasingStyle = transitionConfig["EasingStyle"]
		Color = transitionConfig["Color"]
		info = TweenInfo.new(Duration or 0.5, EasingStyle or Enum.EasingStyle.Linear)
	end
	
	local propertyToUseFrame1 = isScreenGuiFrame1 and "Enabled" or "Visible"
	local propertyToUseFrame2 = isScreenGuiFrame2 and "Enabled" or "Visible"
	
	SwipeIn(info, Color)
	
	if customCallback then customCallback() end
	
	if frame1 then
		frame1[propertyToUseFrame1] = false
	end
	
	if frame2 then
		frame2[propertyToUseFrame2] = true
	end
	
	SwipeOut(info, Color)
end