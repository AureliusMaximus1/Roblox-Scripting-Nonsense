local replicatedStorage = game:GetService("ReplicatedStorage")
local EventsFolder = replicatedStorage.Events
local DoorRunner = require(replicatedStorage.Shared.DoorRunner)
local DoorEvent = EventsFolder.DoorEvent
local DoorsFolder = workspace.Doors

local Debounce = false

local function DoorActivated(Player, Door)
    if Debounce then
        return
    end
    Debounce = true
    -- Ensure Player and Door are valid
    if not Player or not Door then
        warn("Invalid Player or Door")
        return
    end

    -- Example action: Print player name and door name
    print(Player.Name .. " activated the door: " .. Door.Name)
    local Clearance = Door:GetAttribute("Clearance")
   -- if DoorRunner.Permissions[Clearance](Player) then

        print("Access Granted")
        if DoorRunner.DoorTypes[Door.Name] then
            DoorRunner.DoorTypes[Door.Name].Open(Door)
            wait(5)
            DoorRunner.DoorTypes[Door.Name].Close(Door)
            wait(5)
            Debounce = false
        else
            warn("Unknown door type: " .. Door.Name)
        end
--- else
   -- print("Access Denied")
 --end
end
DoorEvent.OnServerEvent:Connect(function(Player, Door)
    DoorActivated(Player, Door)
end)
