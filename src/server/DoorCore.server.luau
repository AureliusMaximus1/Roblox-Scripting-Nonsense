local replicatedStorage = game:GetService("ReplicatedStorage")
local ProximityPromptService = game:GetService("ProximityPromptService")
local EventsFolder = replicatedStorage.Events
local DoorRunner = require(replicatedStorage.Shared.DoorRunner)
local DoorsFolder = workspace.Doors

local function isPlayerInGroup(player, groupId)
    return player:IsInGroup(groupId)
end

local function ProximityTriggered(Prompt, Player)
    if Prompt.Name == "Reader" then
        Prompt.Enabled = false
        local Door = Prompt.Parent.Parent
        local DoorPermissions = require(Door:WaitForChild("Clearances"))
        print("working")
        
        local requiredClearances = DoorPermissions.AllowedClearances -- List of allowed clearances
        local playerClearance = nil
        
        -- Loop through the list and find if the player has a matching clearance
        for _, clearance in ipairs(requiredClearances) do
            if DoorRunner.Clearances[clearance] then -- Check if this clearance exists in the game
                playerClearance = DoorRunner.Clearances[clearance] -- Assign the found clearance
                break -- Stop once we find a valid clearance
            end
        end
        
        -- Check if the player has the required clearance and is in the group
        if playerClearance and playerClearance.GroupID and isPlayerInGroup(Player, playerClearance.GroupID) then
            print("Player has clearance! Access granted.")
            if DoorRunner.DoorTypes[Door.Name] then
                DoorRunner.DoorTypes[Door.Name].Open(Door)
            end
        else
            print("You do not have the required clearance to open this door")
        end
    end
end
ProximityPromptService.PromptTriggered:Connect(ProximityTriggered)