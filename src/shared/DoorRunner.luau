local DoorRunner = {}
local TweenService = game:GetService("TweenService")

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
        end
   
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
    
}


DoorRunner.Clearances = {
   ["MTF Clearance"] = {
    GroupID = 4096130
   },
   ["Ethics Clearance"] = {
    GroupID = 4095963
   }
   -- Add more clearances here
}
return DoorRunner