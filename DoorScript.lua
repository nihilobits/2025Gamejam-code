local TweenService = game:GetService("TweenService")
local doorModel = script.Parent
local clickDetector = doorModel:WaitForChild("ClickDetector")
local tweenInfo = TweenInfo.new(
	1,
	Enum.EasingStyle.Quad,
	Enum.EasingDirection.Out
)

local tweenOpen = TweenService:Create(doorModel.HingePart, tweenInfo, {CFrame= doorModel.HingePart.CFrame * CFrame.Angles(math.rad(120),0,0)})
local tweenClose = TweenService:Create(doorModel.HingePart, tweenInfo, {CFrame= doorModel.HingePart.CFrame * CFrame.Angles(0,0,0)})

local open = false
local debounce = false
clickDetector.MouseClick:Connect(function()
	if open == false and debounce == false then
		open = true
		debounce = true
		script.doorsound:Play()
		tweenOpen:Play()
		tweenOpen.Completed:Connect(function()
			debounce = false
		end)
		
		task.delay(7, function()
			if open then
				open=false
				debounce = true
				script.doorsound:Play()
				tweenClose:Play()
				tweenClose.Completed:Connect(function()
					debounce = false
				end)
			end
		end)
		
	elseif open == true and debounce == false then
		open = false
		debounce = true
		script.doorsound:Play()
		tweenClose:Play()
		tweenClose.Completed:Connect(function()
			debounce = false
		end)
	end
end)
