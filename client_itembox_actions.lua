function Slowdown()
    Citizen.CreateThread(function()
        helpMessage("You are being Slowed")
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        local currspeed = GetEntitySpeed(vehicle)
        local maxSpeed = GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel")
        disablePlayerEjection = true
        local countdowntime = GetGameTimer() + 10*1000
        while math.floor((countdowntime - GetGameTimer())/1000) >= 0 do
            SetEntityMaxSpeed(vehicle, 10.0)
            Citizen.Wait(0)
        end
        disablePlayerEjection = false
        SetEntityMaxSpeed(vehicle,maxSpeed)
    end)
end

function Speedup()
    Citizen.CreateThread(function()
        helpMessage("Whoooooooosh!!!")
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        local currspeed = GetEntitySpeed(vehicle)
        local maxSpeed = GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel")
        local countdowntime = GetGameTimer() + 0.1*1000
        while math.floor((countdowntime - GetGameTimer())/1000) >= 0 do
            Citizen.Wait(100)
        end
        SetVehicleForwardSpeed(vehicle , 80.0 )
        
    end)
end

function InvertVehicleControls()
    helpMessage("Your controls are inverted.")
    Citizen.CreateThread(function()
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        local countdowntime = GetGameTimer() + 10*1000
        SetVehicleControlsInverted(vehicle, true)
            while math.floor((countdowntime - GetGameTimer())/1000) >= 0 do
                Citizen.Wait(100)
            end
        SetVehicleControlsInverted(vehicle, false)
    end)
end

function PlayerWantedLevel()
    helpMessage("You are wanted.")

    local selected_WantedLevel = choose_element(WantedLevels, probabilities_WantedLevels)

    Citizen.CreateThread(function()
        SetPlayerWantedLevel(PlayerId(),selected_WantedLevel, false)
        SetPlayerWantedLevelNow(PlayerId(), false)
        local countdowntime = GetGameTimer() + 10*1000
            while math.floor((countdowntime - GetGameTimer())/1000) >= 0 do
                Citizen.Wait(100)
            end
        ClearPlayerWantedLevel(PlayerId())
    end)
end

function SpawnRamp()
    helpMessage("RAAAAAAAAAAAAAAAAAAAAMP it!!!")
    math.randomseed(GetGameTimer())  
    local selected_Ramp = choose_element(RampType, probabilities_Ramp)
    
    Citizen.CreateThread(function()
    local coordinates = getPosinHeading(PlayerPedId())
    local ramp = CreateObject(selected_Ramp,coordinates.x,coordinates.y,coordinates.z-1, true, true, true)
    local heading = GetEntityHeading(PlayerPedId())
   
    SetEntityHeading(ramp, heading)
    local countdowntime = GetGameTimer() + 5*1000
        while math.floor((countdowntime - GetGameTimer())/1000) >= 0 do
            Citizen.Wait(100)
        end
    DeleteObject(ramp)
    end)

end