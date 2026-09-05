local Curtain = {}
Curtain.__index = Curtain

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGUI = Player.PlayerGui

local CreateTransitionFrames = require(script.CreateTransitionFrames)
local ConfigTypes = require(script.ConfigTypes)

function Curtain.new()
	local self = setmetatable({}, Curtain)
	
	self.transitionGUI = PlayerGUI:FindFirstChild("TransitionGUI")
	if not self.transitionGUI then
		self.transitionGUI = Instance.new("ScreenGui")
		self.transitionGUI.IgnoreGuiInset = true
		self.transitionGUI.ResetOnSpawn = false
		self.transitionGUI.Name = "TransitionGUI"
		self.transitionGUI.DisplayOrder = 999999
		
		self.transitionGUI:SetAttribute("IsTransitioning", false)
		
		self.transitionGUI.Parent = PlayerGUI
		
		CreateTransitionFrames(self.transitionGUI)
	end
	
	return self
end

function Curtain:Grid(frame1 : GuiObject, frame2 : GuiObject, transitionConfig : ConfigTypes.GridConfig, customCallback: (() -> ())?)		
	Transition("Grid", frame1, frame2, transitionConfig, customCallback, self.transitionGUI)
end

function Curtain:Slide(frame1 : GuiObject, frame2 : GuiObject, transitionConfig : ConfigTypes.SlideConfig, customCallback: (() -> ())?)	
	Transition("Slide", frame1, frame2, transitionConfig, customCallback, self.transitionGUI)
end

function Curtain:Fade(frame1 : GuiObject, frame2 : GuiObject, transitionConfig : ConfigTypes.FadeConfig, customCallback: (() -> ())?)	
	Transition("Fade", frame1, frame2, transitionConfig, customCallback, self.transitionGUI)
end

function Curtain:Iris(frame1 : GuiObject, frame2 : GuiObject, transitionConfig : ConfigTypes.IrisConfig, customCallback: (() -> ())?)	
	Transition("Iris", frame1, frame2, transitionConfig, customCallback, self.transitionGUI)
end

function Curtain:Swipe(frame1 : GuiObject, frame2 : GuiObject, transitionConfig : ConfigTypes.IrisConfig, customCallback: (() -> ())?)	
	Transition("Swipe", frame1, frame2, transitionConfig, customCallback, self.transitionGUI)
end

function Curtain:Blinds(frame1 : GuiObject, frame2 : GuiObject, transitionConfig : ConfigTypes.IrisConfig, customCallback: (() -> ())?)	
	Transition("Blinds", frame1, frame2, transitionConfig, customCallback, self.transitionGUI)
end

function Transition(transitionName, frame1, frame2, transitionConfig, customCallback, transitionGUI)
	if not script.Transitions[transitionName] then error(`Invalid transition {transitionName}`) end
	if not frame1 and not frame2 then error(`Invalid frames {frame1}, {frame2}`) end
	if transitionGUI:GetAttribute("IsTransitioning") then return end
	transitionGUI:SetAttribute("IsTransitioning", true)
	
	if not frame1 then
		warn(`[{script.Name}]: Frame 1 is nil, assuming no source frame. Delete this warning in the script if this is intentional.`)
	end
	
	if not frame2 then
		warn(`[{script.Name}]: Frame 2 is nil, assuming no secondary frame. Delete this warning in the script if this is intentional.`)
	end
	
	local isScreenGuiFrame1 = frame1 and frame1:IsA("ScreenGui")
	local isScreenGuiFrame2 = frame2 and frame2:IsA("ScreenGui")
	
	local transition = require(script.Transitions[transitionName])
	transition(frame1, frame2, isScreenGuiFrame1, isScreenGuiFrame2, transitionConfig, customCallback)
	
	transitionGUI:SetAttribute("IsTransitioning", false)
end

return Curtain.new()


-- MADE BY THE GOAT MOEDEFV