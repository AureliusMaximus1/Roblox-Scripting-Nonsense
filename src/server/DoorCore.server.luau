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
        local requiredClearance = DoorPermissions.AllowedClearances
        local clearanceInfo = DoorRunner.Clearances

        if clearanceInfo and isPlayerInGroup(Player, clearanceInfo.GroupID) then
            print("You have the required clearance to open this door")
            if DoorRunner.DoorTypes[Door.Name] then
                DoorRunner.DoorTypes[Door.Name].Open(Door)
            end
        else
            print("You do not have the required clearance to open this door")
        end
    end
end
ProximityPromptService.PromptTriggered:Connect(ProximityTriggered)