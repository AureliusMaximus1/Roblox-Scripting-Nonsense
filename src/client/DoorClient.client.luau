local ProximityPromptService = game:GetService("ProximityPromptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local Events = ReplicatedStorage.Events

local ProximityGUI = ReplicatedStorage:WaitForChild("ProximityPrompts")

ProximityPromptService.PromptShown:Connect(function(Proximity)
    if Proximity.Name == "Reader" then
        local success, error = pcall(function()
            local ProxGUIClone = ProximityGUI:Clone()
            ProxGUIClone.Parent = localPlayer.PlayerGui
            ProxGUIClone.Prompt.Adornee = Proximity.Parent
        end)
        if not success then
            warn(error)
        end
    end
end)

ProximityPromptService.PromptHidden:Connect(function(Proximity)
    if Proximity.Name == "Reader" then
        local ProxGUIClone = localPlayer.PlayerGui:FindFirstChild("ProximityPrompts")
        if ProxGUIClone then
            ProxGUIClone:Destroy()
        end
    end
end)
