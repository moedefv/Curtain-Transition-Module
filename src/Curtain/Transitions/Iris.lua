local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
local PlayerGUI = Player.PlayerGui
local TransitionGUI = PlayerGUI:WaitForChild("TransitionGUI")
local IrisFrame = TransitionGUI:WaitForChild("IrisFrame")
local IrisScale = IrisFrame:WaitForChild("UIScale")

local function IrisIn(info, Color)
	local scaleIn = TweenService:Create(IrisScale, info, {Scale = 20})
	
	IrisFrame.BackgroundColor3 = Color or Color3.fromRGB(0, 0, 0)
	IrisFrame.Visible = true
	
	scaleIn:Play()
	scaleIn.Completed:Wait()
end

local function IrisOut(info, Color)
	local scaleOut = TweenService:Create(IrisScale, info, {Scale = 0})
		
	scaleOut:Play()
	scaleOut.Completed:Wait()
	
	IrisFrame.Visible = false
end

return function(frame1, frame2, isScreenGuiFrame1, isScreenGuiFrame2, transitionConfig, customCallback)
	local info
	local Color

	if not transitionConfig then
		info = TweenInfo.new(1, Enum.EasingStyle.Linear)
	else
		local Duration = transitionConfig["Duration"]
		local EasingStyle = transitionConfig["EasingStyle"]

		Color = transitionConfig["Color"]

		info = TweenInfo.new(Duration or 1, EasingStyle or Enum.EasingStyle.Linear)
	end

	local propertyToUseFrame1 = isScreenGuiFrame1 and "Enabled" or "Visible"
	local propertyToUseFrame2 = isScreenGuiFrame2 and "Enabled" or "Visible"

	IrisIn(info, Color)

	if customCallback then customCallback() end

	if frame1 then
		frame1[propertyToUseFrame1] = false
	end

	if frame2 then
		frame2[propertyToUseFrame2] = true
	end

	IrisOut(info, Color)
end