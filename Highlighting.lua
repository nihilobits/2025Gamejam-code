local UIS = game:GetService("UserInputService")
local plr = game.Players.LocalPlayer
local mouse = plr:GetMouse()
local hl = Instance.new("Highlight")
hl.FillColor = Color3.fromRGB(255, 255, 255)
hl.Enabled = false
hl.Parent = workspace
local last = nil

UIS.InputChanged:Connect(function()
	local t = mouse.Target
	local m = t and t:FindFirstAncestorWhichIsA("Model")
	local ok = m and m:GetAttribute("HL") == true 
		and (plr.Character.Head.Position - m:GetPivot().Position).Magnitude < 15

	if ok and m ~= last then
		hl.Adornee = m
		hl.Enabled = true
		last = m
	elseif not ok then
		hl.Enabled = false
		last = nil
	end
end)
