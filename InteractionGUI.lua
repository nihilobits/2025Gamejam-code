local UIS = game:GetService("UserInputService")
local Mouse = game.Players.LocalPlayer:GetMouse()
local UI = script.Parent
local last = nil
UI.TextLabel.AnchorPoint = Vector2.new(0,1)
Mouse.Move:Connect(function()
	local t = Mouse.Target
	local m = t and t:FindFirstAncestorWhichIsA("Model")
	local ok = m and m:GetAttribute("HL") == true and (game.Players.LocalPlayer.Character.Head.Position - m:GetPivot().Position).Magnitude < 15
	if ok then
		UI.Enabled = true	
		last = m
	elseif not ok then
		UI.Enabled = false
		last = nil
	end
	
	UI.TextLabel.Position = UDim2.fromOffset( UIS:GetMouseLocation().X, UIS:GetMouseLocation().Y)
end)
