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
        Citizen.InvokeNative(0xC8E9B6B71B8E660D, vehicle, true, 2.5, 1.0, 4.0, false)
        -- SetVehicleNitroEnabled(vehicle,true)
        -- SetVehicleMod(vehicle,17,17,false)
        local countdowntime = GetGameTimer() + 10*1000
        while math.floor((countdowntime - GetGameTimer())/1000) >= 0 do
            Citizen.Wait(100)
        end
        -- SetVehicleNitroEnabled(vehicle,false)
        Citizen.InvokeNative(0xC8E9B6B71B8E660D, vehicle, false, 0, 0, 0, false)
    end)
end