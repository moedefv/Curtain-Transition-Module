local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Player = Players.LocalPlayer
local PlayerGUI = Player.PlayerGui
local TransitionGUI = PlayerGUI:WaitForChild("TransitionGUI")
local BlindsFrame = TransitionGUI:WaitForChild("BlindsFrame")

local function BlindsIn(info, Color)
	local inTween

	for i = 1, 40 do
		local column = BlindsFrame[i]
		
		inTween = TweenService:Create(column, info, {BackgroundTransparency = 0})
		
		column.BackgroundColor3 = Color or Color3.fromRGB(0, 0, 0)
		column.Visible = true
		
		inTween:Play()
		task.wait(0.02)
	end

	inTween.Completed:Wait()
end

local function BlindsOut(info, Color)
	local outTween

	for i = 1, 40 do
		local column = BlindsFrame[i]
		
		outTween = TweenService:Create(column, info, {BackgroundTransparency = 1})
		
		column.BackgroundColor3 = Color or Color3.fromRGB(0, 0, 0)

		outTween:Play()		
		task.wait(0.02)
	end

	outTween.Completed:Wait()
	
	for _, column in BlindsFrame:GetChildren() do
		if not column:IsA("Frame") then continue end
		
		column.Visible = false
	end
end

return function(frame1, frame2, isScreenGuiFrame1, isScreenGuiFrame2, transitionConfig, customCallback)
	local info
	local Color
	
	if not transitionConfig then
		info = TweenInfo.new(0.25, Enum.EasingStyle.Linear)
	else
		local Duration = transitionConfig["Duration"]
		local EasingStyle = transitionConfig["EasingStyle"]
		Color = transitionConfig["Color"]
		info = TweenInfo.new(Duration or 0.25, EasingStyle or Enum.EasingStyle.Linear)
	end
	
	local propertyToUseFrame1 = isScreenGuiFrame1 and "Enabled" or "Visible"
	local propertyToUseFrame2 = isScreenGuiFrame2 and "Enabled" or "Visible"
	
	BlindsIn(info, Color)
	
	if customCallback then customCallback() end
	
	if frame1 then
		frame1[propertyToUseFrame1] = false
	end
	
	if frame2 then
		frame2[propertyToUseFrame2] = true
	end
	
	BlindsOut(info, Color)
end