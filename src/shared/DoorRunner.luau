local DoorRunner = {}
local TweenService = game:GetService("TweenService")

DoorRunner.DoorsInUse = {}

DoorRunner.DoorTypes = {
    DoubleSlidingDoor = {
        
        Open = function(Door)
            local DoorTween1 = TweenService:Create(Door.Right, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.In, 0, false, 0), {CFrame = Door.Right.CFrame * CFrame.new(0, 0, 3)})
            DoorTween1:Play()
            local DoorTween2 = TweenService:Create(Door.Left, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.In, 0, false, 0), {CFrame = Door.Left.CFrame * CFrame.new(0, 0, -3)})
            DoorTween2:Play()
        end,
        Close = function(Door)
            local DoorTween1 = TweenService:Create(Door.Right, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.In, 0, false, 0), {CFrame = Door.Right.CFrame * CFrame.new(0, 0, -3)})
            DoorTween1:Play()
            local DoorTween2 = TweenService:Create(Door.Left, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.In, 0, false, 0), {CFrame = Door.Left.CFrame * CFrame.new(0, 0, 3)})
            DoorTween2:Play()
            DoorTween2.Completed:Connect(function()
                for i, DoorNumber in ipairs(DoorRunner.DoorsInUse) do
                    if DoorNumber == Door then
                        table.remove(DoorRunner.DoorsInUse, i)
                    end
                end
            end)
       
    end,
    },

    SwingDoor = {
        Open = function(Door)
            local DoorTween = TweenService:Create(Door.Swivel, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In, 0, false, 0), {CFrame = Door.Swivel.CFrame * CFrame.fromEulerAngles(0, math.rad(-90), 0)})
            DoorTween:Play()
        end,
        Close = function(Door)
            local DoorTween = TweenService:Create(Door.Swivel, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In, 0, false, 0), {CFrame = Door.Swivel.CFrame * CFrame.fromEulerAngles(0, math.rad(90), 0)})
            DoorTween:Play()
        end
    }
    -- Add more door types here
    
}


DoorRunner.Clearances = {
   ["MTF Clearance"] = {
    GroupID = 4096130
   },
   ["Ethics Clearance"] = {
    GroupID = 32011413
   }

   -- Add more clearances here
}

DoorRunner.UITweens = {
    FillIn = function(UI, PromptTime)
        local Tween = TweenService:Create(UI, TweenInfo.new(PromptTime, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0), {Size = UDim2.new(1, 0, -1, 0)})
        Tween:Play()

        DoorRunner.CancelTween = function(Prompt)
            Prompt.Enabled = false
            Tween:Cancel()
            local CancelTween = TweenService:Create(UI, TweenInfo.new(.5, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0), {Size = UDim2.new(1, 0, 0, 0)})
            CancelTween:Play()
            CancelTween.completed:Connect(function()
                Prompt.Enabled = true
            end)
        end
        
    end
}
return DoorRunner