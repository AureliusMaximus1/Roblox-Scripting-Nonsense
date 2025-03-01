local ProximityPromptService = game:GetService("ProximityPromptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local DoorRunner = require(ReplicatedStorage.Shared:WaitForChild("DoorRunner"))
local ProximityGUI = ReplicatedStorage:WaitForChild("FrontPromptGUI")

local promptDisabled = false

ProximityPromptService.PromptShown:Connect(function(Proximity)
    if Proximity.Name == "Reader" then
        local success, error = pcall(function()
            local existingGUI = localPlayer.PlayerGui:FindFirstChild("FrontPromptGUI")
            if existingGUI then
                existingGUI:Destroy()
            end
            local ProxGUIClone = ProximityGUI:Clone()
            ProxGUIClone.Parent = localPlayer.PlayerGui
            ProxGUIClone.Adornee = Proximity.Parent
        end)
        if not success then
            warn(error)
        end
    end
end)

ProximityPromptService.PromptButtonHoldBegan:Connect(function(Proximity)
    if Proximity.Name == "Reader" then
        local success, error = pcall(function()
            local ProxUI = localPlayer.PlayerGui:FindFirstChild("FrontPromptGUI")
            if ProxUI then
                local FillFrame = ProxUI.MainFrame.Fill
                DoorRunner.UITweens.FillIn(FillFrame, Proximity.HoldDuration)
            end
        end)
        if not success then
            warn(error)
        end
    end
end)

ProximityPromptService.PromptButtonHoldEnded:Connect(function(Proximity)
    if Proximity.Name == "Reader" then
        DoorRunner.CancelTween(Proximity)
        promptDisabled = true
    end
end)

ProximityPromptService.PromptHidden:Connect(function(Proximity)
    if Proximity.Name == "Reader" then
        print("Prompt Hidden")
        local ProxGUIClone = localPlayer.PlayerGui:FindFirstChild("FrontPromptGUI")
        if ProxGUIClone and not promptDisabled then
            print("Destroying GUI")
            ProxGUIClone:Destroy()
        end
        promptDisabled = false
    end
end)
