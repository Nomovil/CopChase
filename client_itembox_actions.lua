function Slowdown()
    print("Slowdown")
    Citizen.CreateThread(function()
        helpMessage("You are being Slowed")
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        local currspeed = GetEntitySpeed(vehicle)
        local maxSpeed = GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel")
        disablePlayerEjection = true
        local countdowntime = GetGameTimer() + RESETTIME_SLOWDOWN*1000
        while math.floor((countdowntime - GetGameTimer())/1000) >= 0 do
            SetEntityMaxSpeed(vehicle, MAX_SPEED_SLOWED)
            Citizen.Wait(0)
        end
        disablePlayerEjection = false
        SetEntityMaxSpeed(vehicle,maxSpeed)
    end)
end

function Speedup()
    print("Speedup")
    Citizen.CreateThread(function()
        helpMessage("Whoooooooosh!!!")
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        local currspeed = GetEntitySpeed(vehicle)
        local maxSpeed = GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel")
        local countdowntime = GetGameTimer() + RESETTIME_SPEEDUP*1000
        while math.floor((countdowntime - GetGameTimer())/1000) >= 0 do
            Citizen.Wait(100)
        end
        SetVehicleForwardSpeed(vehicle , BOOST_FORCE )
        
    end)
end

function InvertVehicleControls()
    print("InvertCtrl")
    helpMessage("Your controls are inverted.")
    Citizen.CreateThread(function()
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        local countdowntime = GetGameTimer() + RESTETTIME_INVERT_CRTL*1000
        SetVehicleControlsInverted(vehicle, true)
            while math.floor((countdowntime - GetGameTimer())/1000) >= 0 do
                Citizen.Wait(100)
            end
        SetVehicleControlsInverted(vehicle, false)
    end)
end

function PlayerWantedLevel()
    print("Wanted")
    helpMessage("You are wanted.")

    local selected_WantedLevel = choose_element(WantedLevels, probabilities_WantedLevels)

    Citizen.CreateThread(function()
        SetPlayerWantedLevel(PlayerId(),selected_WantedLevel, false)
        SetPlayerWantedLevelNow(PlayerId(), false)
        local countdowntime = GetGameTimer() + RESTTIME_WANTED_LEVEL*1000
            while math.floor((countdowntime - GetGameTimer())/1000) >= 0 do
                Citizen.Wait(100)
            end
        ClearPlayerWantedLevel(PlayerId())
    end)
end

function SpawnRamp()
    print("Ramp")
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

function fixcar()
    print("Fix Car")
    helpMessage("Your Vehicle got repaired")
    local localPlayerPed = GetPlayerPed(-1)
    local localVehicle = GetVehiclePedIsIn(localPlayerPed, false)
    SetVehicleFixed(localVehicle)
end


function add_speedboster()
    print("Speedbooster")
    helpMessage("You got a speed booster")
    number_of_speedboosts =  number_of_speedboosts + 1
end


function slowCops()
    print("SlowingCops")
    TriggerServerEvent("PING:slowdownCops")
end

function slowThiefs()
    print("Slowing Thiefs")
    TriggerServerEvent("PING:slowdownThief")
end