local replicatedStorage = game:GetService("ReplicatedStorage")
local ProximityPromptService = game:GetService("ProximityPromptService")
local EventsFolder = replicatedStorage.Events
local DoorRunner = require(replicatedStorage.Shared.DoorRunner)
local DoorsFolder = workspace.Doors



local function IsPlayerInGroup(Player, GroupID)
    if Player and GroupID then
        return Player:IsInGroup(GroupID)
    end
    return false
end

local function checkPlayerClearance(Player, requiredClearances)
    for _, clearance in ipairs(requiredClearances) do
        local clearanceInfo = DoorRunner.Clearances[clearance]
        if clearanceInfo and IsPlayerInGroup(Player, clearanceInfo.GroupID) then
            return true -- Player has the required clearance
        end
    end
    return false -- Player does not have any required clearance
end



local function ProximityTriggered(Prompt, Player)
    if Prompt.Name == "Reader" then
        local Door = Prompt.Parent.Parent
        local DoorPermissions = require(Door:WaitForChild("Clearances"))
        print("working")
        
        local requiredClearances = DoorPermissions.AllowedClearances

        if checkPlayerClearance(Player, requiredClearances) then
            warn("You have the required clearance to open this door.")
                if DoorRunner.DoorTypes[Door.Name] then
                    if table.find(DoorRunner.DoorsInUse, Door) then
                        warn("This door is already in use.")
                        return
                    end
                    DoorRunner.DoorTypes[Door.Name].Open(Door)
                    table.insert(DoorRunner.DoorsInUse, Door)
                    print(DoorRunner.DoorsInUse)
                    wait(5)
                    DoorRunner.DoorTypes[Door.Name].Close(Door)
                    wait(5)
             else
                warn("This door type is not supported.")
                return
            end
             else
            warn("You do not have the required clearance to open this door.")
        end
    end
end
ProximityPromptService.PromptTriggered:Connect(ProximityTriggered)