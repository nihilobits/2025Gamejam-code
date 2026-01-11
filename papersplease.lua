local normalburger = game.Lighting.NormalBurger
local dynamiteburger = game.Lighting.DynamiteBurger
local angryburger = game.Lighting.AngryBurger
local angrydynamiteburger = game.Lighting.AngryDynamiteBurger
local nextObj = game.Lighting.next
local approved = game.Lighting.StampApproved
local denied = game.Lighting.StampDenied
local hideablepart = workspace:FindFirstChild("HideableRoom")
local paperspart = game.Lighting:FindFirstChild("PapersModel")
local TweenService = game:GetService("TweenService")
local floor1 = game.Lighting:FindFirstChild("Floor1")
local floor2 = game.Workspace:FindFirstChild("Floor2")

local enabled = false
local stampedApproved = false
local stampedDenied = false
local wrong = 0
local debounce = true
local stopLoop = false
local currentBurger = nil
local eventsConnected = false

script.Parent.ClickDetector.MouseClick:Connect(function()
	if not enabled then
		enabled = true
		stopLoop = false

		hideablepart.Parent = game.Lighting
		paperspart.Parent = workspace
		nextObj.Parent = workspace
		approved.Parent = workspace
		denied.Parent = workspace
		floor1.Parent = workspace

		if not eventsConnected then
			eventsConnected = true

			workspace.StampDenied.ClickDetector.MouseClick:Connect(function()
				if not stopLoop then
					stampedDenied = true
				end
			end)

			workspace.StampApproved.ClickDetector.MouseClick:Connect(function()
				if not stopLoop then
					stampedApproved = true
				end
			end)

			workspace.next.ClickDetector.MouseClick:Connect(function()
				if enabled and debounce == false and not stopLoop then
					gameloop()
				end
			end)
		end

		script.open:Play()
		gameloop()
	end
end)

function gameloop()
	if stopLoop then return end

	debounce = true
	stampedApproved = false
	stampedDenied = false

	local r = math.random(1,4)
	local selectedburger = nil

	if r == 1 then selectedburger = normalburger:Clone()
	elseif r == 2 then selectedburger = dynamiteburger:Clone()
	elseif r == 3 then selectedburger = angryburger:Clone()
	elseif r == 4 then selectedburger = angrydynamiteburger:Clone()
	end

	currentBurger = selectedburger
	selectedburger.Parent = workspace

	moveBurger(selectedburger, CFrame.new(252.35, 56.9, 161.584) * CFrame.Angles(0,0,math.rad(-90)))

	for i = 1,200 do
		if stopLoop then return end
		task.wait(0.01)
	end

	if stopLoop then return end

	script.paperspls:Play()

	repeat task.wait() until stampedDenied or stampedApproved or stopLoop
	if stopLoop then return end

	if stampedDenied then
		script.denied:Play()
		if r == 1 or r == 4 then
			wrong += 1
			workspace.rules.SurfaceGui["1"].Text = wrong.."/3"
			if wrong == 3 then
				game.ReplicatedStorage:WaitForChild("PapersEventDone").Value= true
				floor1.Transparency = 1
				floor2.Transparency = 1
				floor1.CanCollide = false
				floor2.CanCollide = false
				
				return
			end
		end
		moveBurger(selectedburger, CFrame.new(242.35, 56.9, 142.584) * CFrame.Angles(0,math.rad(90),math.rad(-90)))
		task.wait(1)
		if currentBurger then currentBurger:Destroy() end
		currentBurger = nil
		stampedDenied = false
		stampedApproved = false
		debounce = false
		return
	end

	if stampedApproved then
		script.approved:Play()
		if r == 2 or r == 3 then
			wrong += 1
			workspace.rules.SurfaceGui["1"].Text = wrong.."/3"
			if wrong == 3 then
				game.ReplicatedStorage:WaitForChild("PapersEventDone").Value= true
				floor1.Transparency = 1
				floor2.Transparency = 1
				floor1.CanCollide = false
				floor2.CanCollide = false
				return
			end
		end
		moveBurger(selectedburger, CFrame.new(242.35, 56.9, 180.584) * CFrame.Angles(0,math.rad(-90),math.rad(-90)))
		task.wait(1)
		if currentBurger then currentBurger:Destroy() end
		currentBurger = nil
		stampedDenied = false
		stampedApproved = false
		debounce = false
		return
	end
end

function moveBurger(burger, cframe)
	local Tween = TweenService:Create(burger.PrimaryPart, TweenInfo.new(2), {CFrame = cframe})
	Tween:Play()
end

game.ReplicatedStorage.reset.Event:Connect(function()
	stopLoop = true
	enabled = false
	game.ReplicatedStorage:WaitForChild("PapersEventDone").Value= false
	if currentBurger then
		currentBurger:Destroy()
		currentBurger = nil
	end

	hideablepart.Parent = workspace
	paperspart.Parent = game.Lighting
	nextObj.Parent = game.Lighting
	approved.Parent = game.Lighting
	denied.Parent = game.Lighting
	floor1.Parent = game.Lighting

	wrong = 0
	stampedApproved = false
	stampedDenied = false
	debounce = true

	floor1.Transparency = 0
	floor2.Transparency = 0
	floor1.CanCollide = true
	floor2.CanCollide = true

	workspace.rules.SurfaceGui["1"].Text = "0/3"

	task.wait(0.1)
	stopLoop = false
end)
