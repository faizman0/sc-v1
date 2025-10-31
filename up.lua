-- LocalScript: put inside the Tool
local Tool = script.Parent
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FireShotEvent = ReplicatedStorage:WaitForChild("FireShotEvent")

local player = Players.LocalPlayer
local mouse = nil

Tool.Equipped:Connect(function()
    -- get mouse when equipped
    mouse = player:GetMouse()
end)

Tool.Activated:Connect(function()
    if not mouse then return end
    -- Send the mouse.Hit position to server for direction
    FireShotEvent:FireServer(mouse.Hit.p)
end)
-- ServerScript: place in ServerScriptService
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Debris = game:GetService("Debris")
local RunService = game:GetService("RunService")

local FireShotEvent = ReplicatedStorage:WaitForChild("FireShotEvent")

-- CONFIG
local PROJECTILE_SPEED = 300 -- studs per second (adjust for faster/slower)
local PROJECTILE_SIZE = Vector3.new(0.6,0.6,2) -- appearance size
local LIFETIME = 5 -- seconds before projectile auto-destroys
local DAMAGE_PERCENT = 0.70 -- 70% of target MaxHealth on hit
local BURN_TICKS = 4 -- number of overtime ticks
local BURN_INTERVAL = 0.5 -- seconds between ticks
local BURN_PERCENT_PER_TICK = 0.05 -- each tick deals 5% of MaxHealth (these are additional)

-- helper to create projectile
local function createProjectile(origin, direction, owner)
    local part = Instance.new("Part")
    part.Size = PROJECTILE_SIZE
    part.CFrame = CFrame.new(origin, origin + direction) * CFrame.new(0,0,-PROJECTILE_SIZE.Z/2)
    part.CanCollide = false
    part.Anchored = false
    part.Name = "FireProjectile"
    part.Material = Enum.Material.Neon
    part.BrickColor = BrickColor.new("Bright orange")
    part.CastShadow = false
    part.Parent = workspace

    -- Visual: fire particle
    local fire = Instance.new("ParticleEmitter")
    fire.Texture = "rbxasset://textures/particles/flame_main.dds"
    fire.Rate = 100
    fire.Lifetime = NumberRange.new(0.2, 0.5)
    fire.Speed = NumberRange.new(0,0)
    fire.Rotation = NumberRange.new(0,360)
    fire.RotSpeed = NumberRange.new(-180,180)
    fire.Parent = part

    -- Tag the projectile with owner to prevent friendly/self hits
    local ownerTag = Instance.new("ObjectValue")
    ownerTag.Name = "Owner"
    ownerTag.Value = owner
    ownerTag.Parent = part

    -- Physics: use a BodyVelocity to make consistent speed
    local bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    bv.Velocity = direction.Unit * PROJECTILE_SPEED
    bv.Parent = part

    -- cleanup
    Debris:AddItem(part, LIFETIME)
    return part
end

-- damage & burn logic
local function applyDamageAndBurn(humanoid)
    if not humanoid or not humanoid.Parent then return end
    local maxHP = humanoid.MaxHealth or 100
    local initialDamage = math.floor(maxHP * DAMAGE_PERCENT + 0.5)
    humanoid:TakeDamage(initialDamage)

    -- Burn overtime
    spawn(function()
        for i = 1, BURN_TICKS do
            if humanoid.Health <= 0 then break end
            wait(BURN_INTERVAL)
            if humanoid and humanoid.Health > 0 then
                local tickDamage = math.floor(maxHP * BURN_PERCENT_PER_TICK + 0.5)
                humanoid:TakeDamage(tickDamage)
            end
        end
    end)
end

-- prevent multiple hits on same target per projectile
local function handleProjectileHit(projectile, hitPart)
    if not projectile or not projectile.Parent then return end
    local owner = projectile:FindFirstChild("Owner") and projectile.Owner.Value
    local character = hitPart:FindFirstAncestorOfClass("Model")
    if not character then return end
    local humanoid = character:FindFirstChildWhichIsA("Humanoid")
    if not humanoid or humanoid.Health <= 0 then return end

    -- ignore owner hits
    if owner and character == owner.Character then return end

    -- apply damage & burn
    applyDamageAndBurn(humanoid)

    -- create small hit effect
    local explosion = Instance.new("Part")
    explosion.Size = Vector3.new(0.5,0.5,0.5)
    explosion.Position = projectile.Position
    explosion.Anchored = true
    explosion.CanCollide = false
    explosion.Transparency = 1
    explosion.Parent = workspace
    Debris:AddItem(explosion, 0.3)

    -- destroy projectile
    projectile:Destroy()
end

-- Raycast fallback: in case projectile misses due to physics we add a short ray check each frame
local function projectileHeartbeatWatcher(projectile)
    local prevPos = projectile.Position
    local connection
    connection = RunService.Heartbeat:Connect(function(dt)
        if not projectile.Parent then
            connection:Disconnect()
            return
        end
        local newPos = projectile.Position
        local rayDir = newPos - prevPos
        if rayDir.Magnitude > 0 then
            local rayOrigin = prevPos
            local ray = Ray.new(rayOrigin, rayDir)
            local hitPart, hitPos = workspace:FindPartOnRayWithIgnoreList(ray, {projectile})
            if hitPart then
                handleProjectileHit(projectile, hitPart)
                if connection then connection:Disconnect() end
                return
            end
        end
        prevPos = newPos
    end)
end

-- When server receives a fire request
FireShotEvent.OnServerEvent:Connect(function(player, targetPosition)
    -- Basic validation
    if not player or not player.Character or not player.Character:FindFirstChild("Head") then return end
    local head = player.Character:FindFirstChild("Head")
    if typeof(targetPosition) ~= "Vector3" then return end

    -- origin slightly in front of head / tool handle
    local origin = head.Position + (player.Character.PrimaryPart and player.Character.PrimaryPart.CFrame.LookVector * 1.5 or Vector3.new(0,0,0))

    local direction = (targetPosition - origin)
    if direction.Magnitude == 0 then
        direction = player.Character.PrimaryPart and player.Character.PrimaryPart.CFrame.LookVector or Vector3.new(0,0,-1)
    end

    -- create projectile
    local proj = createProjectile(origin, direction, player)

    -- connect Touched handler (debounced per projectile)
    local hitSet = {}
    proj.Touched:Connect(function(hit)
        if not hit or not hit.Parent then return end
        -- avoid touching things like other projectiles or non-collidable scenery duplicates
        if hit:IsDescendantOf(proj) then return end
        -- ensure we don't handle same humanoid multiple times for this projectile
        local model = hit:FindFirstAncestorOfClass("Model")
        if model and model:FindFirstChildOfClass("Humanoid") then
            local hum = model:FindFirstChildOfClass("Humanoid")
            if hum and not hitSet[hum] then
                hitSet[hum] = true
                handleProjectileHit(proj, hit)
            end
        end
    end)

    -- start ray fallback watcher to ensure high-speed hits detected
    projectileHeartbeatWatcher(proj)
end)
