function FormatTimeForDisplay(time)
    local days = math.floor(time / 86400)
    local remaining = time % 86400
    local hours = math.floor(remaining / 3600)
    remaining = remaining % 3600
    local minutes = math.floor(remaining / 60)
    remaining = remaining % 60
    local seconds = remaining
    if (hours < 10) then
        hours = "0" .. tostring(hours)
    end
    if (minutes < 10) then
        minutes = "0" .. tostring(minutes)
    end
    if (seconds < 10) then
        seconds = "0" .. tostring(seconds)
    end
    local answer = tostring(hours) .. 'h:' .. minutes .. 'm:' .. seconds .. 's'
    return answer
end

-- check if player got tasered
function CheckIfPlayerGotTasered()
    local ped = GetPlayerPed(-1)
    local tasered = IsPedBeingStunned(ped, 0)
    local inverted_tasered = not tasered
    return inverted_tasered
end

function CheckPlayerIsInVehicle()
    local ped = GetPlayerPed(-1)
    return GetVehiclePedIsIn(ped, false) > 0
end

function StartCountdown(time_to_count_down)
    time = GetGameTimer() + time_to_count_down * 1000
end

function GetRemainingTime()
    return math.floor((time - GetGameTimer()) / 1000)
end

function SetCountdownTime(time_to_count_down)
    return GetGameTimer() + time_to_count_down * 1000
end

function GetRemainingCountdownTime(countdownEndTime)
    return math.floor((countdownEndTime - GetGameTimer()) / 1000)
end

function MonitorMisterXState()
    Citizen.CreateThread(function()
        -- while( checkPlayerIsInVehicle()) do
        --     Wait(100)
        -- end
        local startTime = GetGameTimer()
        local showTimer = true
        local seconds_text
        -- while (showTimer and checkPlayerIsInVehicle()) do
        while (showTimer and CheckIfPlayerGotTasered()) do
            local seconds = math.ceil((GetGameTimer() - startTime) / 1000)
            seconds_text = FormatTimeForDisplay(seconds)
            -- drawTxt(seconds_text, 4, { 255, 255, 255 }, 0.7, 0.85, 0.01)
            Citizen.Wait(0)
        end
        local name = GetPlayerName(PlayerId())
        local message = ("%s escaped for: %s"):format(name, seconds_text)
        -- printToPlayer(mesage)
        TriggerServerEvent("PING:deliverMessage", message)


        TriggerServerEvent("PING:ThiefLost")
    end)
end

function CreateStopwatchThread()
    Citizen.CreateThread(function()
        -- startTime = GetGameTimer()
        Timer.Start();
        local showTimer = true
        while (showTimer) do
            -- seconds = math.ceil((GetGameTimer() - startTime) / 1000)
            -- seconds = Timer.GetElapsed() / 1000 -- GetElapsedCustomTime returns milliseconds, so we divide by 1000 to get seconds
            local seconds = Timer.GetElapsedTime() /
                1000 -- GetElapsedTime returns milliseconds, so we divide by 1000 to get seconds
            local seconds_text = FormatTimeForDisplay(seconds)
            drawTxt(seconds_text, 4, { 255, 255, 255 }, 0.7, 0.85, 0.01)
            Citizen.Wait(0)
        end
        -- local message = ("MisterX escaped for: %s"):format(seconds_text)
        -- -- printToPlayer(mesage)
        -- TriggerServerEvent("PING:deliverMessage",message)
    end)
end

function DisableVehicleControls()
    -- print("Disabling Car Controls")
    DisableControlAction(2, 71, true)
    DisableControlAction(2, 72, true)
end

function EnableVehicleControls()
    -- print("Enabling Car Controls")
    EnableControlAction(2, 71, true)
    EnableControlAction(2, 72, true)
end

function AdjustRunnerCarSettings()
    ModCar(VEHICLE_COLOR)
end

function AdjustCopCarSettings()
    local color = math.random(0, 100)
    ModCar(color)
end

function ModCar(vehicleColor)
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)

    SetVehicleColours(
        vehicle --[[ Vehicle ]],
        vehicleColor --[[ integer ]],
        vehicleColor --[[ integer ]]
    )

    SetVehicleModKit(
        vehicle --[[ Vehicle ]],
        0 --[[ integer ]]
    )

    for modType, modInfo in pairs(VEHICLE_MOD_TABLE) do
        local maxLevel = GetNumVehicleMods(vehicle, modInfo[1])
        SetVehicleMod(vehicle, modInfo[1], maxLevel - 1, false)
    end
end
