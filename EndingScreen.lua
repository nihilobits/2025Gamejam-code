local StarterGui = game:GetService("StarterGui")
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Health, false)


local UIS = game:GetService("UserInputService")
local localplayer = game.Players.LocalPlayer
UIS.InputBegan:Connect(function(input: InputObject, gameProcessedEvent: boolean) 
	if input.KeyCode == Enum.KeyCode.R then
		if game.ReplicatedStorage:WaitForChild("MaxwellEventDone").Value == true and game.ReplicatedStorage:WaitForChild("PapersEventDone").Value == true and game.ReplicatedStorage:WaitForChild("BackroomsEventDone").Value == true and game.ReplicatedStorage:WaitForChild("BurgerLineEventDone").Value == true and game.ReplicatedStorage:WaitForChild("UsEventDone").Value == true then
			
			
			local TweenService = game:GetService("TweenService")
			local frame = localplayer.PlayerGui.winscreen.Frame
			localplayer.PlayerGui.winscreen.Enabled = true
			local frameTween = TweenService:Create(frame, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0})

			local function tweenTextLabels()
				for _, child in ipairs(frame:GetChildren()) do
					if child:IsA("TextLabel") then
						child.TextTransparency = 1
						local textTween = TweenService:Create(child, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0})
						textTween:Play()
					end
				end
			end
			frameTween:Play()
			frameTween.Completed:Connect(function()
				tweenTextLabels()
				wait(10)
				localplayer:Kick()
			end)
		else
			game.ReplicatedStorage:FindFirstChild("RemoteEvent"):FireServer()
			local player = game.Players.LocalPlayer
			local TweenService = game:GetService("TweenService")
			local gui = player:WaitForChild("PlayerGui"):WaitForChild("resetscreen")
			local frame = gui:WaitForChild("Frame")
			local text = frame:WaitForChild("TextLabel")
			frame.BackgroundTransparency = 1
			text.TextTransparency = 1
			local function fade(to, time)
				TweenService:Create(frame, TweenInfo.new(time), {
					BackgroundTransparency = to
				}):Play()
				TweenService:Create(text, TweenInfo.new(time), {
					TextTransparency = to
				}):Play()
				task.wait(time)
			end
			fade(0, 0.3)
			local char = player.Character
			if char then
				local hum = char:FindFirstChildOfClass("Humanoid")
				if hum then
					hum.Health = 0
				end
			end
			player.CharacterAdded:Wait()
			fade(1, 0.3)
		end
	end	
end)
