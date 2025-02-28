local replicatedStorage = game:GetService("ReplicatedStorage")
local ProximityPromptService = game:GetService("ProximityPromptService")
local EventsFolder = replicatedStorage.Events
local DoorRunner = require(replicatedStorage.Shared.DoorRunner)
local DoorsFolder = workspace.Doors


local function ProximityTriggered(Prompt, Player)
local Door = Prompt.Parent.Parent

if Prompt.Name == "Reader" then
    Prompt.Enabled = false
   


end
end
ProximityPromptService.PromptTriggered:Connect(ProximityTriggered)


