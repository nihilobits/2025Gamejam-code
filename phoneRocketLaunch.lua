local answer1 = "1234"
local currentinput = ""
local nukehatch = workspace:FindFirstChild("NukeHatch")
local hatchtop = workspace:FindFirstChild("hatchtop")
local rocket = workspace:FindFirstChild("Rocket")

local runningThread
local resetConnection

for i = 0, 9 do
	local button = script.Parent[tostring(i)]
	if button and button:FindFirstChild("ClickDetector") then
		button.ClickDetector.MouseClick:Connect(function()
			currentinput = currentinput .. tostring(i)
			script.Parent.screen.SurfaceGui.TextLabel.Text = currentinput
			script.dial:Play()
		end)
	end
end

script.Parent.Clear.ClickDetector.MouseClick:Connect(function()
	script.Parent.screen.SurfaceGui.TextLabel.Text = ""
	currentinput = ""	
end)

script.Parent.Approve.ClickDetector.MouseClick:Connect(function()
	if runningThread then
		task.cancel(runningThread)
	end

	runningThread = task.spawn(function()
		if answer1 ~= currentinput then
			script.Parent.screen.SurfaceGui.TextLabel.Text = "womp, womp."
			currentinput = ""
			script.wompwomp:Play()
			return
		end

		if answer1 == currentinput then
			currentinput = ""
			game.ReplicatedStorage:WaitForChild("UsEventDone").Value = true

			if resetConnection then
				resetConnection:Disconnect()
			end

			resetConnection = game.ReplicatedStorage.reset.Event:Connect(function()
				task.cancel(runningThread)
			end)

			local cfv = Instance.new("CFrameValue")
			cfv.Value = rocket:GetPivot()
			cfv.Parent = script

			local TweenService = game:GetService("TweenService")
			local startPivot = rocket:GetPivot()
			local endCFrame = CFrame.new(startPivot.Position + Vector3.new(0, 500, 0)) * CFrame.fromOrientation(startPivot:ToOrientation())
			local tween = TweenService:Create(cfv, TweenInfo.new(13, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Value = endCFrame})
			tween.Parent = rocket

			script.Parent.screen.SurfaceGui.TextLabel.Text = "00000000"
			script.usanthem:Play()
			script.armed:Play()

			nukehatch.PrimaryPart.Position = Vector3.new(159.022, 58.75, 106)
			nukehatch.PrimaryPart.Orientation = Vector3.new(-30, -90, -90)
			nukehatch.Second.Position = Vector3.new(158.522, 57.884, 106)
			nukehatch.Second.Orientation = Vector3.new(-30, -90, -90)
			hatchtop.Transparency = 1

			task.wait(1)

			for i = 10, 5, -1 do
				script.Parent.screen.SurfaceGui.TextLabel.Text = i
				task.wait(1)
			end

			script.rocket:Play()

			for i = 5, 0, -1 do
				script.Parent.screen.SurfaceGui.TextLabel.Text = i
				rocket.Engine.fire.Enabled = true
				rocket.Engine.smoke.Enabled = true
				task.wait(1)
			end

			tween:Play()

			cfv.Changed:Connect(function(value)
				rocket:PivotTo(value)
			end)
		end
	end)
end)

game.ReplicatedStorage.reset.Event:Connect(function()
	nukehatch.PrimaryPart.Position = Vector3.new(182.022, 51.5, 106)
	nukehatch.PrimaryPart.Orientation = Vector3.new(0, 90, 90)
	nukehatch.Second.Position = Vector3.new(182.022, 52, 106)
	nukehatch.Second.Orientation = Vector3.new(0, 90, 90)
	rocket.PrimaryPart.CFrame = CFrame.new(182.022, 9.25, 106) * CFrame.Angles(0, 0, math.rad(90))
	rocket.Engine.smoke.Enabled = false
	rocket.Engine.fire.Enabled = false
	script.usanthem:Stop()
	script.usanthem.TimePosition = 0
	script.rocket:Stop()
	script.rocket.TimePosition = 0
	rocket:WaitForChild("Tween"):Cancel()
	rocket:MoveTo(Vector3.new(182.022, 9.25, 106))
	game.ReplicatedStorage:WaitForChild("UsEventDone").Value = false
end)
