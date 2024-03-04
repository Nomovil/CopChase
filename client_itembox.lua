itemboxes = {}
MARKERRANGE = 5
MARKERSYMBOL = 32
actionActive = true
ACTIONTIMES = 2



function selectAction()
    local index = math.random(0,100)
    print("Action Choice", index);
    -- SpawnRamp()
    if index < 50 then
        print("Slowing down Thiefs")
        -- Slowdown()
        TriggerServerEvent("PING:slowdownThief")
    elseif index > 50 then
        -- Speedup()
        print("Slowing down Cops")
        TriggerServerEvent("PING:slowdownCops")
    end
end




-- Main Thread
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if not IsPedInAnyVehicle(PlayerPedId(), false) then
            goto continue
        end
        drawExistingItemBox()
        e_pressed()
        ::continue::
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        if not IsPedInAnyVehicle(PlayerPedId(), false) then
            goto continue
        end
        for index, pos in ipairs(itemboxes) do
            MarkerisinReach(pos,index)
        end
        ::continue::
    end
end)


function createNewItemBox(pos)
    table.insert(itemboxes,pos)
end

function e_pressed()
    if IsControlJustReleased(0, 19) then
        local pos = getPosinHeading(PlayerPedId())
        PlayerWantedLevel()
        -- TriggerServerEvent("PING:createItemBox",pos)
        -- createNewItemBox(pos)
    end
end

function drawExistingItemBox()
    for index, pos in ipairs(itemboxes) do
        DrawMarker(MARKERSYMBOL,pos.x,pos.y,pos.z,0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 2.0, 2.0, 0, 255, 0, 255, true, true, 2, nil, nil, false)
    end
end

function MarkerisinReach(pos,index)
    local distance = GetDistanceBetweenCoords(pos,GetEntityCoords(PlayerPedId()))
    if distance < MARKERRANGE then
        TriggerServerEvent("PING:removeItemBox",index)
        selectAction()
    elseif distance >= 1000 then
        table.remove(itemboxes,index)
    end
end


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

-- function SelectRampType()
--     RampTypes = {"prop_mp_ramp_01","prop_mp_ramp_02","prop_mp_ramp_03"}
function choose_element(elements, probabilities)
    -- Überprüfen, ob die Länge der Liste und die der Wahrscheinlichkeiten übereinstimmen
    if #elements ~= #probabilities then
        error("Die Längen der Liste und der Wahrscheinlichkeiten müssen übereinstimmen.")
    end
    
    -- Kumulative Summe der Wahrscheinlichkeiten berechnen
    local cumulative_probabilities = {}
    local cumulative_sum = 0
    for i, prob in ipairs(probabilities) do
        cumulative_sum = cumulative_sum + prob
        cumulative_probabilities[i] = cumulative_sum
    end
    
    -- Zufallszahl zwischen 0 und 1 generieren
    local random_value = math.random()
    
    -- Element auswählen basierend auf der Zufallszahl und den kumulativen Wahrscheinlichkeiten
    for i, cumulative_prob in ipairs(cumulative_probabilities) do
        if random_value <= cumulative_prob then
            return elements[i]
        end
    end
end

function ActionTimer()
    Citizen.CreateThread(function()
        actionActive = true
        Citizen.Wait(ACTIONTIMES*1000)
        actionActive = false
    end)
end

function getPosinHeading(playerid)
    fwd,_,_,pos = GetEntityMatrix(playerid)
    local multiplyer = math.random(10,100)
    local newx = pos.x + fwd.x*multiplyer
    local newy = pos.y + fwd.y*multiplyer
    local newPosHeading = vec(newx,newy,pos.z)
    retval, newz = GetSafeCoordForPed(newPosHeading.x,newPosHeading.y,newPosHeading.z,false,newz,0)
    return newz
end


function drawTxt(content, font, colour, scale, x, y)
    SetTextFont(font)
    SetTextScale(scale, scale)
    SetTextColour(colour[1],colour[2],colour[3], 255)
    SetTextEntry("STRING")
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextDropShadow()
    SetTextEdge(4, 0, 0, 0, 255)
    SetTextOutline()
    AddTextComponentString(content)
    DrawText(x, y)
end


function printToPlayer(msg)
    TriggerEvent('chat:addMessage', {
        color = { 255, 0, 0},
        multiline = true,
        args = {"[Ping]", msg}
        }
    )
end

RegisterNetEvent("PING:slowDown",function()
    ActionTimer()
    Slowdown()
end)

RegisterNetEvent("PING:createItemBox",function(pos)
    createNewItemBox(pos)
end)

RegisterNetEvent("PING:removeItemBox", function(index)
    table.remove(itemboxes,index)
    Citizen.Wait(100)
end)

function helpMessage(text, duration)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayHelp(0, false, true, duration or 5000)
end