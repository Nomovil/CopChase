slowdown_visible = false
slowdown_alpha = 1.0
function Slowdown()
    -- print("Slowdown")
    slowdown_visible = true
    Citizen.CreateThread(function()
        -- helpMessage("You are being Slowed")
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        local currspeed = GetEntitySpeed(vehicle)
        local maxSpeed = GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel")
        disablePlayerEjection = true
        local countdowntime = GetGameTimer() + RESETTIME_SLOWDOWN*1000
        while math.floor((countdowntime - GetGameTimer())/1000) >= 0 do
            SetEntityMaxSpeed(vehicle, MAX_SPEED_SLOWED)
            slowdown_alpha = math.floor((countdowntime - GetGameTimer())/1000) / RESETTIME_SLOWDOWN
            Citizen.Wait(0)
        end
        disablePlayerEjection = false
        SetEntityMaxSpeed(vehicle,maxSpeed)
        slowdown_visible = false
        slowdown_alpha = 1.0
    end)

end


function Speedup()
    -- print("Speedup")
    Citizen.CreateThread(function()
        -- helpMessage("Whoooooooosh!!!")
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

inv_ctrl_alpha = 1.0
inv_ctrl_visible = false
function InvertVehicleControls()
    -- print("InvertCtrl")
    -- helpMessage("Your controls are inverted.")
    inv_ctrl_visible = true
    Citizen.CreateThread(function()
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        local countdowntime = GetGameTimer() + RESTETTIME_INVERT_CRTL*1000
        SetVehicleControlsInverted(vehicle, true)
        while math.floor((countdowntime - GetGameTimer())/1000) >= 0 do
            inv_ctrl_alpha = math.floor((countdowntime - GetGameTimer())/1000) / RESTETTIME_INVERT_CRTL
            Citizen.Wait(100)
        end
        inv_ctrl_alpha = 1.0
        inv_ctrl_visible = false
        SetVehicleControlsInverted(vehicle, false)
    end)
end

wanted_visible = false
wanted_alpha = 1.0
function PlayerWantedLevel()
    -- print("Wanted")
    wanted_visible = true
    local selected_WantedLevel = choose_element(WantedLevels, probabilities_WantedLevels)

    Citizen.CreateThread(function()
        SetPlayerWantedLevel(PlayerId(),selected_WantedLevel, false)
        SetPlayerWantedLevelNow(PlayerId(), false)
        local countdowntime = GetGameTimer() + RESTTIME_WANTED_LEVEL*1000
            while math.floor((countdowntime - GetGameTimer())/1000) >= 0 do
                Citizen.Wait(100)
                wanted_alpha = math.floor((countdowntime - GetGameTimer())/1000) / RESTTIME_WANTED_LEVEL

            end
        ClearPlayerWantedLevel(PlayerId())
        wanted_alpha = 1.0
        wanted_visible = false
    end)
end

ramp_visible = false
ramp_alpha = 1.0
function SpawnRamp()
    -- print("Ramp")
    -- helpMessage("RAAAAAAAAAAAAAAAAAAAAMP it!!!")
    ramp_visible = true
    math.randomseed(GetGameTimer())  
    local selected_Ramp = choose_element(RampType, probabilities_Ramp)
    
    Citizen.CreateThread(function()
    local coordinates = getPosinHeading(PlayerPedId())
    local ramp = CreateObject(selected_Ramp,coordinates.x,coordinates.y,coordinates.z-1, true, true, true)
    local heading = GetEntityHeading(PlayerPedId())
   
    SetEntityHeading(ramp, heading)
    local countdowntime = GetGameTimer() + RESTTIME_RAMP*1000
        while math.floor((countdowntime - GetGameTimer())/1000) >= 0 do
            Citizen.Wait(100)
            ramp_alpha = math.floor((countdowntime - GetGameTimer())/1000) / RESTTIME_RAMP
        end
    DeleteObject(ramp)
    ramp_visible = false
    ramp_alpha = 1.0
    end)

end

fixcar_visible = false
function fixcar()
    -- print("Fix Car")
    -- helpMessage("Your Vehicle got repaired")
    fixcar_visible = true
    Citizen.CreateThread(function()
        local localPlayerPed = GetPlayerPed(-1)
        local localVehicle = GetVehiclePedIsIn(localPlayerPed, false)
        SetVehicleFixed(localVehicle)
        Wait(2000)
        fixcar_visible = false
    end)
end

speedboost_added_visible = false
function add_speedboster()
    -- print("Speedbooster")
    -- helpMessage("You got a speed booster")
    speedboost_added_visible = true
    Citizen.CreateThread(function()
        number_of_speedboosts =  number_of_speedboosts + 1
        Wait(2000)
        speedboost_added_visible = false
    end)
end


slowCops_visible = false
slowCops_alpha = 1.0
function slowCops()
    print("SlowingCops")
    slowCops_visible = true
    Citizen.CreateThreadNow(function()
        TriggerServerEvent("PING:slowdownCops")
        local countdowntime = GetGameTimer() + RESETTIME_SLOWDOWN*1000
        while math.floor((countdowntime - GetGameTimer())/1000) >= 0 do
            slowCops_alpha = math.floor((countdowntime - GetGameTimer())/1000) / RESETTIME_SLOWDOWN
            Citizen.Wait(0)
        end
        slowCops_visible = false
        slowCops_alpha = 1.0
    end)

end


slowThiefs_visible = false
slowThiefs_alpha = 1.0
function slowThiefs()
    print("Slowing Thiefs")
    slowThiefs_visible = true
    CreateThread(function()
        TriggerServerEvent("PING:slowdownThief")
        local countdowntime = GetGameTimer() + RESETTIME_SLOWDOWN*1000
        while math.floor((countdowntime - GetGameTimer())/1000) >= 0 do
            slowThiefs_alpha = math.floor((countdowntime - GetGameTimer())/1000) / RESETTIME_SLOWDOWN
            Citizen.Wait(0)
        end
        slowThiefs_visible = false
        slowThiefs_alpha = 1.0
    end)
end
