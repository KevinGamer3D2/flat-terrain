local Players = game:GetService("Players")

local function onDescendantAdded(descendant: Instance)
	if not descendant:IsA("BasePart") or descendant.Name ~= "Handle" then
		return
	end

	local parent = descendant.Parent
	if not parent or not parent:IsA("Accoutrement") then
		return
	end

	descendant.EnableFluidForces = false
	descendant.CanCollide = false
	descendant.CanTouch = false
	descendant.CanQuery = false
	descendant.Massless = true
	descendant.Locked = true
end

local function onCharacterAdded(character: Model)
	for _, descendant in ipairs(character:GetDescendants()) do
		onDescendantAdded(descendant)
	end

	character.DescendantAdded:Connect(onDescendantAdded)
end

local function onPlayerAdded(player: Player)
	local character = player.Character
	if character then
		onCharacterAdded(character)
	end

	player.CharacterAdded:Connect(onCharacterAdded)
end

for _, player in ipairs(Players:GetPlayers()) do
	task.spawn(onPlayerAdded, player)
end

Players.PlayerAdded:Connect(onPlayerAdded)
