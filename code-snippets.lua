-- ======================= --
-- SCP-173 System (Snippet)
-- This snippet demonstrates getting the nearest players, the movement and the main loop.
-- ============================================================================================== --

-- Gets the player the nearest of SCP-173, ignoring those further away than MAX_DISTANCE.
local function getNearestPlayer()
	local nearestDistance, nearestPlayer, humanoid

	for _, player in ipairs(Players:GetPlayers()) do
		local character = player.Character
		if not character then continue end

		local hrp: Part = character:FindFirstChild("HumanoidRootPart")
		if not hrp then continue end

		local newHumanoid: Humanoid = character:FindFirstChild("Humanoid")
		if not newHumanoid or newHumanoid.Health <= 0 then continue end

		local distance = (hrp.Position - peanutPrimaryPart.Position).Magnitude

		if distance > MAX_DISTANCE or (nearestDistance and distance >= nearestDistance) then continue end

		humanoid = newHumanoid
		nearestDistance = distance
		nearestPlayer = player
	end

	return nearestPlayer, humanoid
end

-- Moves to the nearest player (step-wise), and kills if the distance between the player is under moveDistance.
local function moveToPlayer(player)
	local character = player and player.Character 
	if not character then return end

	local humanoid: Humanoid = character:FindFirstChild("Humanoid")
	if not humanoid or humanoid.Health <= 0 then return end

	local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
	if not humanoidRootPart then return end

	playTeleportSound(true)

	local peanutPos = peanutPrimaryPart.Position
	local hrpPosition = humanoidRootPart.Position

	local distance = (hrpPosition - peanutPos).Magnitude
	local magnitude = (hrpPosition - peanutPos)
	local direction = Vector3.new(magnitude.X, 0, magnitude.Z).Unit

	local step = math.min(moveDistance, distance)
	local newPos = peanutPos + direction * step

	if distance < moveDistance then
		-- Teleport infront of the player
		newPos = hrpPosition - direction * 2
		killPlayer(player)
	end

	local lookTarget = Vector3.new(hrpPosition.X, newPos.Y, hrpPosition.Z)
	peanut:PivotTo(CFrame.lookAt(newPos, lookTarget))
end

-- Function used for the main loop, that checks if any players are watching / blinking.
function Controller.CheckMovement()
	local nearestPlayer, humanoid = getNearestPlayer()
	if not nearestPlayer or not humanoid then return end

	for _, player in ipairs(Players:GetChildren()) do
		if Controller.playersWatching[player]
			and not Controller.playersBlinking[player] then

			playTeleportSound(false)
			return
		end
	end

	local timeSinceWatched = os.clock() - (Controller.lastTimeWatched[nearestPlayer] or 0)
	if timeSinceWatched >= REACTION_TIME then
		if humanoid.Health <= 0 then return end
		moveToPlayer(nearestPlayer)
	end
end
