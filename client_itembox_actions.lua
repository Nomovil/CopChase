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
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        local currspeed = GetEntitySpeed(vehicle)
        local maxSpeed = GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel")
        local countdowntime = GetGameTimer() + 2*1000
        while math.floor((countdowntime - GetGameTimer())/1000) >= 0 do
            SetVehicleForwardSpeed(vehicle , 50.0 )
            Citizen.Wait(100)
        end
        
    end)
end

function InvertVehicleControls()
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
    local WantedLevels = {1,2,3,4,5}
    local probabilities = {0.2,0.2,0.3,0.2,0.1}
    local selected_WantedLevel = choose_element(WantedLevels, probabilities)

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
    math.randomseed(GetGameTimer())  
    local RampType = {"prop_mp_ramp_01", "prop_mp_ramp_02", "prop_mp_ramp_03"}
    local probabilities = {0.3, 0.5, 0.2} 
    local selected_Ramp = choose_element(RampType, probabilities)
    
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