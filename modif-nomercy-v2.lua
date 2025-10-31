local select = select
local pcall, getgenv, next, Vector2, mathclamp, type, mousemoverel = select(1, pcall, getgenv, next, Vector2.new, math.clamp, type, mousemoverel or (Input and Input.MouseMove))

pcall(function()
	getgenv().Aimbot.Functions:Exit()
end)

getgenv().Aimbot = {}
local Environment = getgenv().Aimbot

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local RequiredDistance, Typing, Running, Animation, ServiceConnections = 2000, false, false, nil, {}

Environment.Settings = {
	Enabled = true,
	TeamCheck = false,
	AliveCheck = true,
	WallCheck = false, 
	Sensitivity = 0, 
	ThirdPerson = false, 
	ThirdPersonSensitivity = 3,
	TriggerKey = "MouseButton2",
	Toggle = false,
	LockPart = "Head"
}

Environment.FOVSettings = {
	Enabled = true,
	Visible = true,
	Amount = 90,
	Color = Color3.fromRGB(255, 255, 255),
	LockedColor = Color3.fromRGB(255, 70, 70),
	Transparency = 0.0,
	Sides = 60,
	Thickness = 1,
	Filled = false
}

-- Double Damage Settings
Environment.DoubleDamageSettings = {
	Enabled = false,
	Toggle = false,
	TriggerKey = "Z", -- Default key untuk mengaktifkan double damage
	-- Duration = 5, -- Durasi dalam detik
	-- Cooldown = 30, 
	Multiplier = 2, -- Pengali damage
	Active = false,
	-- OnCooldown = false
}

Environment.FOVCircle = Drawing.new("Circle")

local function CancelLock()
	Environment.Locked = nil
	if Animation then Animation:Cancel() end
	Environment.FOVCircle.Color = Environment.FOVSettings.Color
end

local function GetClosestPlayer()
	if not Environment.Locked then
		RequiredDistance = (Environment.FOVSettings.Enabled and Environment.FOVSettings.Amount or 2000)

		for _, v in next, Players:GetPlayers() do
			if v ~= LocalPlayer then
				if v.Character and v.Character:FindFirstChild(Environment.Settings.LockPart) and v.Character:FindFirstChildOfClass("Humanoid") then
					if Environment.Settings.TeamCheck and v.Team == LocalPlayer.Team then continue end
					if Environment.Settings.AliveCheck and v.Character:FindFirstChildOfClass("Humanoid").Health <= 0 then continue end
					if Environment.Settings.WallCheck and #(Camera:GetPartsObscuringTarget({v.Character[Environment.Settings.LockPart].Position}, v.Character:GetDescendants())) > 0 then continue end

					local Vector, OnScreen = Camera:WorldToViewportPoint(v.Character[Environment.Settings.LockPart].Position)
					local Distance = (Vector2(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2(Vector.X, Vector.Y)).Magnitude

					if Distance < RequiredDistance and OnScreen then
						RequiredDistance = Distance
						Environment.Locked = v
					end
				end
			end
		end
	elseif (Vector2(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2(Camera:WorldToViewportPoint(Environment.Locked.Character[Environment.Settings.LockPart].Position).X, Camera:WorldToViewportPoint(Environment.Locked.Character[Environment.Settings.LockPart].Position).Y)).Magnitude > RequiredDistance then
		CancelLock()
	end
end

-- Double Damage Functions
local function ApplyDoubleDamage()
	if Environment.DoubleDamageSettings.OnCooldown then
		warn("Double Damage is on cooldown!")
		return
	end
	
	Environment.DoubleDamageSettings.Active = true
	Environment.DoubleDamageSettings.OnCooldown = true
	
	-- Simulasi efek visual atau suara
	warn("DOUBLE DAMAGE ACTIVATED! Damage x" .. Environment.DoubleDamageSettings.Multiplier)
	
	-- Simulasi peningkatan damage (ini perlu disesuaikan dengan game spesifik)
	local character = LocalPlayer.Character
	if character then
		-- Di sini Anda perlu menyesuaikan dengan mekanisme damage game
		-- Contoh untuk game yang menggunakan Tool/Weapon:
		for _, tool in ipairs(character:GetChildren()) do
			if tool:IsA("Tool") then
				-- Meningkatkan damage tool (sesuaikan dengan struktur game)
				local originalDamage = tool:GetAttribute("OriginalDamage")
				if not originalDamage then
					originalDamage = tool:GetAttribute("Damage") or 10
					tool:SetAttribute("OriginalDamage", originalDamage)
				end
				tool:SetAttribute("Damage", originalDamage * Environment.DoubleDamageSettings.Multiplier)
			end
		end
	end
	
	-- Timer untuk durasi double damage
	delay(Environment.DoubleDamageSettings.Duration, function()
		Environment.DoubleDamageSettings.Active = false
		warn("Double Damage ended")
		
		-- Kembalikan damage ke normal
		local character = LocalPlayer.Character
		if character then
			for _, tool in ipairs(character:GetChildren()) do
				if tool:IsA("Tool") then
					local originalDamage = tool:GetAttribute("OriginalDamage")
					if originalDamage then
						tool:SetAttribute("Damage", originalDamage)
					end
				end
			end
		end
		
		-- Cooldown timer
		delay(Environment.DoubleDamageSettings.Cooldown - Environment.DoubleDamageSettings.Duration, function()
			Environment.DoubleDamageSettings.OnCooldown = false
			warn("Double Damage is ready!")
		end)
	end)
end

local function ToggleDoubleDamage()
	if Environment.DoubleDamageSettings.Toggle then
		if not Environment.DoubleDamageSettings.Active and not Environment.DoubleDamageSettings.OnCooldown then
			ApplyDoubleDamage()
		end
	else
		ApplyDoubleDamage()
	end
end

ServiceConnections.TypingStartedConnection = UserInputService.TextBoxFocused:Connect(function()
	Typing = true
end)

ServiceConnections.TypingEndedConnection = UserInputService.TextBoxFocusReleased:Connect(function()
	Typing = false
end)

local function Load()
	ServiceConnections.RenderSteppedConnection = RunService.RenderStepped:Connect(function()
		if Environment.FOVSettings.Enabled and Environment.Settings.Enabled then
			Environment.FOVCircle.Radius = Environment.FOVSettings.Amount
			Environment.FOVCircle.Thickness = Environment.FOVSettings.Thickness
			Environment.FOVCircle.Filled = Environment.FOVSettings.Filled
			Environment.FOVCircle.NumSides = Environment.FOVSettings.Sides
			Environment.FOVCircle.Color = Environment.FOVSettings.Color
			Environment.FOVCircle.Transparency = Environment.FOVSettings.Transparency
			Environment.FOVCircle.Visible = Environment.FOVSettings.Visible
			Environment.FOVCircle.Position = Vector2(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
		else
			Environment.FOVCircle.Visible = false
		end

		if Running and Environment.Settings.Enabled then
			GetClosestPlayer()

			if Environment.Locked then
				if Environment.Settings.ThirdPerson then
					Environment.Settings.ThirdPersonSensitivity = mathclamp(Environment.Settings.ThirdPersonSensitivity, 0.1, 5)

					local Vector = Camera:WorldToViewportPoint(Environment.Locked.Character[Environment.Settings.LockPart].Position)
					mousemoverel((Vector.X - UserInputService:GetMouseLocation().X) * Environment.Settings.ThirdPersonSensitivity, (Vector.Y - UserInputService:GetMouseLocation().Y) * Environment.Settings.ThirdPersonSensitivity)
				else
					if Environment.Settings.Sensitivity > 0 then
						Animation = TweenService:Create(Camera, TweenInfo.new(Environment.Settings.Sensitivity, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {CFrame = CFrame.new(Camera.CFrame.Position, Environment.Locked.Character[Environment.Settings.LockPart].Position)})
						Animation:Play()
					else
						Camera.CFrame = CFrame.new(Camera.CFrame.Position, Environment.Locked.Character[Environment.Settings.LockPart].Position)
					end
				end

			Environment.FOVCircle.Color = Environment.FOVSettings.LockedColor

			end
		end
	end)

	ServiceConnections.InputBeganConnection = UserInputService.InputBegan:Connect(function(Input)
		if not Typing then
			-- Aimbot Trigger
			pcall(function()
				if Input.KeyCode == Enum.KeyCode[Environment.Settings.TriggerKey] then
					if Environment.Settings.Toggle then
						Running = not Running

						if not Running then
							CancelLock()
						end
					else
						Running = true
					end
				end
			end)

			pcall(function()
				if Input.UserInputType == Enum.UserInputType[Environment.Settings.TriggerKey] then
					if Environment.Settings.Toggle then
						Running = not Running

						if not Running then
							CancelLock()
						end
					else
						Running = true
					end
				end
			end)
			
			-- Double Damage Trigger
			pcall(function()
				if Input.KeyCode == Enum.KeyCode[Environment.DoubleDamageSettings.TriggerKey] then
					if Environment.DoubleDamageSettings.Enabled then
						ToggleDoubleDamage()
					end
				end
			end)
		end
	end)

	ServiceConnections.InputEndedConnection = UserInputService.InputEnded:Connect(function(Input)
		if not Typing then
			if not Environment.Settings.Toggle then
				pcall(function()
					if Input.KeyCode == Enum.KeyCode[Environment.Settings.TriggerKey] then
						Running = false; CancelLock()
					end
				end)

				pcall(function()
					if Input.UserInputType == Enum.UserInputType[Environment.Settings.TriggerKey] then
						Running = false; CancelLock()
					end
				end)
			end
		end
	end)
end

Environment.Functions = {}

function Environment.Functions:Exit()
	for _, v in next, ServiceConnections do
		v:Disconnect()
	end

	if Environment.FOVCircle.Remove then Environment.FOVCircle:Remove() end

	getgenv().Aimbot.Functions = nil
	getgenv().Aimbot = nil
	
	Load = nil; GetClosestPlayer = nil; CancelLock = nil
	ApplyDoubleDamage = nil; ToggleDoubleDamage = nil
end

function Environment.Functions:Restart()
	for _, v in next, ServiceConnections do
		v:Disconnect()
	end

	Load()
end

function Environment.Functions:ResetSettings()
	Environment.Settings = {
		Enabled = true,
		TeamCheck = false,
		AliveCheck = true,
		WallCheck = false,
		Sensitivity = 0, 
		ThirdPerson = false, 
		ThirdPersonSensitivity = 3,
		TriggerKey = "MouseButton2",
		Toggle = false,
		LockPart = "Head" 
	}

	Environment.FOVSettings = {
		Enabled = true,
		Visible = true,
		Amount = 90,
		Color = Color3.fromRGB(255, 255, 255),
		LockedColor = Color3.fromRGB(255, 70, 70),
		Transparency = 0.5,
		Sides = 60,
		Thickness = 1,
		Filled = false
	}
	
	Environment.DoubleDamageSettings = {
		Enabled = false,
		Toggle = false,
		TriggerKey = "Z",
		Duration = 5,
		Cooldown = 30,
		Multiplier = 2,
		Active = false,
		OnCooldown = false
	}
end

-- Fungsi untuk mengatur double damage
function Environment.Functions:SetDoubleDamageEnabled(state)
	Environment.DoubleDamageSettings.Enabled = state
end

function Environment.Functions:SetDoubleDamageKey(key)
	Environment.DoubleDamageSettings.TriggerKey = key
end

function Environment.Functions:SetDoubleDamageMultiplier(multiplier)
	Environment.DoubleDamageSettings.Multiplier = multiplier
end

function Environment.Functions:SetDoubleDamageDuration(duration)
	Environment.DoubleDamageSettings.Duration = duration
end

function Environment.Functions:SetDoubleDamageCooldown(cooldown)
	Environment.DoubleDamageSettings.Cooldown = cooldown
end

function Environment.Functions:GetDoubleDamageStatus()
	return {
		Active = Environment.DoubleDamageSettings.Active,
		OnCooldown = Environment.DoubleDamageSettings.OnCooldown,
		TimeRemaining = Environment.DoubleDamageSettings.Cooldown
	}
end

Load()